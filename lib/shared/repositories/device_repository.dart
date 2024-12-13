import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    deferred as tracking_status;
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IDeviceRepository, order: -1)
class DeviceRepository implements IDeviceRepository {
  DeviceRepository({
    required FirebaseMessaging firebaseMessaging,
    required DeviceInfoPlugin deviceInfoPlugin,
    required AppInfoRepository buildRepository,
  })  : _firebaseMessaging = firebaseMessaging,
        _deviceInfoPlugin = deviceInfoPlugin,
        _buildRepository = buildRepository;

  final FirebaseMessaging _firebaseMessaging;
  final DeviceInfoPlugin _deviceInfoPlugin;
  final AppInfoRepository _buildRepository;

  @override
  Future<Either<SomeFailure, DeviceInfoModel?>> getDevice({
    List<DeviceInfoModel>? initialList,
  }) async {
    if (Config.isReleaseMode) {
      var id = '';
      SomeFailure? failure;
      String? fcm;
      final platform = PlatformEnum.getPlatform;

      final idResult = await getDeviceId(platformValue: platform);
      idResult.fold(
        (l) => failure = l,
        (r) => id = r,
      );
      if (failure != null) return Left(failure!);

      final deviceInfoExist = initialList?.any(
        (deviceInfo) =>
            deviceInfo.deviceId == id && deviceInfo.fcmToken != null,
      );

      if (deviceInfoExist ?? false) {
        return const Right(null);
      }

      final fcmResult = await getFcm(platformValue: platform);
      fcmResult.fold(
        (l) => failure = l,
        (r) => fcm = r,
      );
      if (failure != null) return Left(failure!);

      // This Method contain try catch. If has error return
      // AppInfoRepository.defaultValue
      // This Method contain try catch. If has error return
      // AppInfoRepository.defaultValue
      final buildInfo = await _buildRepository.getBuildInfo();
      return Right(
        DeviceInfoModel(
          deviceId: id,
          fcmToken: fcm,
          date: ExtendedDateTime.current,
          build: buildInfo.buildNumber,
          platform: platform,
        ),
      );
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<SomeFailure, String>> getDeviceId({
    PlatformEnum? platformValue,
  }) async {
    try {
      final platform = platformValue ?? PlatformEnum.getPlatform;
      String deviceId;
      switch (platform) {
        case PlatformEnum.android:
          final dev = await _deviceInfoPlugin.androidInfo;
          deviceId = dev.id;
        case PlatformEnum.ios:
          final dev = await _deviceInfoPlugin.iosInfo;

          deviceId = dev.identifierForVendor ?? 'unknown';
        case PlatformEnum.web:
          final dev = await _deviceInfoPlugin.webBrowserInfo;

          // Get the user's browser name and platform
          // (I think it will be enough unique for one user)
          deviceId = '${dev.browserName} Platform: '
              '${dev.platform ?? dev.userAgent?.getUserPlatform ?? 'unkown'}';
        case PlatformEnum.unknown:
          final dev = await _deviceInfoPlugin.deviceInfo;
          deviceId = dev.toString();
      }
      return Right(deviceId);
    } catch (e, stack) {
      return Left(
        SomeFailure.serverError(
          error: e,
          stack: stack,
          tag: 'Device(getDeviceId)',
          tagKey: ErrorText.repositoryKey,
          data: 'Platform: $platformValue',
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, String?>> getFcm({
    PlatformEnum? platformValue,
  }) async {
    try {
      if (!await _firebaseMessaging.isSupported()) return const Right(null);
      final platform = platformValue ?? PlatformEnum.getPlatform;
      String? fcmToken;

      var notificationSettings =
          await _firebaseMessaging.getNotificationSettings();
      switch (notificationSettings.authorizationStatus) {
        case AuthorizationStatus.denied:
          if (platform.isAndroid) {
            notificationSettings = await handleRequestPermission(platform);
          }
        case AuthorizationStatus.notDetermined:
          notificationSettings = await handleRequestPermission(
            platform,
            provisional: true,
          );
        case AuthorizationStatus.provisional:
          notificationSettings = await handleRequestPermission(platform);
        case AuthorizationStatus.authorized:
          break;
      }

      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          (platform.isIOS &&
              notificationSettings.authorizationStatus ==
                  AuthorizationStatus.provisional)) {
        String? apnsToken;
        // For iOS, retrieve the apnsToken, which is required for FCM to send
        // messages via APNs.
        // If the apnsToken is not available (e.g., user hasn't granted
        // permissions),
        // FCM won't be able to deliver push notifications to this iOS device.
        if (platform.isIOS) {
          /// Message from firebase website - https://firebase.google.com/docs/cloud-messaging/flutter/client#access_the_registration_token
          // Warning: In iOS SDK 10.4.0 and higher, it is a requirement that
          // the APNs token is available before making API requests.
          // The APNs token is not guaranteed to have been received
          // before making FCM plugin API requests.
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
        // Proceed with generating the fcmToken only if:
        // - The platform is not iOS (no apnsToken is needed),
        // - or the platform is iOS and apnsToken is successfully retrieved.
        // The fcmToken, combined with apnsToken on iOS, enables proper delivery
        // of notifications.
        if (!platform.isIOS || apnsToken != null) {
          fcmToken = await _firebaseMessaging.getToken(
            vapidKey: KSecurityKeys.firebaseVapidKey,
          );
        }
      }

      return Right(fcmToken);
    } catch (e, stack) {
      final failure = FcmTokenGetFailure.fromCode(
        error: e,
        stack: stack,
        tag: 'Device(getFcm)',
        tagKey: ErrorText.repositoryKey,
        data: 'Platform: $platformValue',
      ).status;
      if (failure != null) {
        return Left(
          failure,
        );
      }
      return const Right(null);
    }
  }

  /// This method should return a value because, on the first run,
  /// if the user has allowed notifications, we would otherwise receive an
  /// [AuthorizationStatus.notDetermined].
  Future<NotificationSettings> handleRequestPermission(
    PlatformEnum platformValue, {
    bool provisional = false,
  }) async {
    if (platformValue.isIOS) {
      await tracking_status.loadLibrary();
      final trackingAuthorizationStatus = await tracking_status
          .AppTrackingTransparency.trackingAuthorizationStatus;
      // see if app tracking transparency is enabled
      if (trackingAuthorizationStatus ==
              tracking_status.TrackingStatus.notDetermined ||
          KTest.isTest) {
        // Request system's tracking authorization dialog
        try {
          await tracking_status.AppTrackingTransparency
              .requestTrackingAuthorization();
        } catch (e) {
          // Handle error
        }
      }

      return _firebaseMessaging.requestPermission(
        provisional: provisional,
      );
    } else {
      return _firebaseMessaging.requestPermission(
        // All This parameters only for iOS/macOS
        alert: false,
        badge: false,
        sound: false,
      );
    }
  }
}
