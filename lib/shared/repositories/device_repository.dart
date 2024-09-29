import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IDeviceRepository, order: -1)
class DeviceRepository implements IDeviceRepository {
  DeviceRepository(
    this._firebaseMessaging,
    this._deviceInfoPlugin,
    this._buildRepository,
  );

  final FirebaseMessaging _firebaseMessaging;
  final DeviceInfoPlugin _deviceInfoPlugin;
  final AppInfoRepository _buildRepository;

  @override
  Future<Either<SomeFailure, DeviceInfoModel?>> getDevice({
    List<DeviceInfoModel>? initialList,
  }) async {
    if (KTest.testReleaseMode) {
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
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, String?>> getFcm({
    PlatformEnum? platformValue,
  }) async {
    try {
      final platform = platformValue ?? PlatformEnum.getPlatform;
      String? fcmToken;

      final notificationSettings =
          await _firebaseMessaging.getNotificationSettings();

      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.denied) {
        if (platform.isAndroid) {
          await handleRequestPermission(platform);
        }
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.notDetermined) {
        await handleRequestPermission(
          platform,
          provisional: platform.isIOS,
        );
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        await handleRequestPermission(platform);
      }

      // You may set the permission requests to "provisional" which allows the
      // user to choose what type
      // of notifications they would like to receive once the user receives a
      // notification.
      // final notificationSettings = await _firebaseMessaging
      // .requestPermission(
      //   provisional: platform.isIOS,
      // );

      // final notificationSettings =
      //     await _firebaseMessaging.getNotificationSettings();

      // For apple platforms, ensure the APNS token is available before making
      // any FCM plugin API calls
      // final apnsToken = await _firebaseMessaging.getAPNSToken();

      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          (platform.isIOS &&
              notificationSettings.authorizationStatus ==
                  AuthorizationStatus.provisional)) {
        fcmToken = await _firebaseMessaging.getToken(
          vapidKey: Config.isProduction
              ? KSecurityKeys.firebaseProdVapidKey
              : KSecurityKeys.firebaseDevVapidKey,
        );
      }

      return Right(fcmToken);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  Future<void> handleRequestPermission(
    PlatformEnum platformValue, {
    bool provisional = false,
  }) async {
    if (platformValue.isIOS) {
      // see if app tracking transparency is enabled
      if (await AppTrackingTransparency.trackingAuthorizationStatus ==
          TrackingStatus.notDetermined) {
        // Request system's tracking authorization dialog
        try {
          await AppTrackingTransparency.requestTrackingAuthorization();
        } catch (e) {
          // Handle error
        }
        await _firebaseMessaging.requestPermission(
          provisional: platformValue.isIOS && provisional,
        );
      } else {
        await _firebaseMessaging.requestPermission(
          provisional: platformValue.isIOS && provisional,
        );
      }
    } else {
      await _firebaseMessaging.requestPermission();
    }
    {}
  }
}
