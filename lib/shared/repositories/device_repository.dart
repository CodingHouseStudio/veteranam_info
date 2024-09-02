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
  ) {
    // Initialization logic can't use await directly in constructor
    _messagingInit();
  }

  final FirebaseMessaging _firebaseMessaging;
  final DeviceInfoPlugin _deviceInfoPlugin;
  final AppInfoRepository _buildRepository;

  Future<void> _messagingInit() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
    } catch (e) {
      // catch if setAutoInitEnabled failure
    }
  }

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
    // if (kReleaseMode) {
    // if (Platform.isIOS || Platform.isAndroid) {
    //   // String? temp2;
    //   // final temp = DeviceInfoPlugin();
    //   // final messaging = FirebaseMessaging.instance;
    //   final notificationSettings = await messaging.getNotificationSettings();
    //   if (notificationSettings.authorizationStatus ==
    //       AuthorizationStatus.authorized) {
    //     try {
    //       temp2 = await messaging.getToken();
    //     } catch (e, stack) {
    //       return null;
    //     }
    //   }
    //   String deviceId;
    //   if (Platform.isAndroid) {
    //     final dev = await temp.androidInfo;
    //     deviceId = dev.id;
    //   } else {
    //     final dev = await temp.iosInfo;
    //     if (dev.identifierForVendor != null) {
    //       deviceId = dev.identifierForVendor!;
    //     } else {
    //       deviceId = 'unknown';
    //     }
    //   }
    //   if (temp2 != null) {
    //     final result = DeviceModel(
    //       fcmToken: temp2,
    //       deviceId: deviceId,
    //     );
    //     // debugPrint('device is $result');
    //     return result;
    //   } else {
    //     return null;
    //   }
    // }
    // return null;
    // }
    // return null;
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

      // You may set the permission requests to "provisional" which allows the
      // user to choose what type
      // of notifications they would like to receive once the user receives a
      // notification.
      final notificationSettings = await _firebaseMessaging.requestPermission(
        provisional: platform.isIOS,
      );

      // final notificationSettings =
      //     await _firebaseMessaging.getNotificationSettings();

      // For apple platforms, ensure the APNS token is available before making
      // any FCM plugin API calls
      final apnsToken = await _firebaseMessaging.getAPNSToken();

      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized &&
          (!platform.isIOS || apnsToken != null)) {
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
}
