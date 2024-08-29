import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IDeviceRepository)
class DeviceRepository implements IDeviceRepository {
  DeviceRepository(this._firebaseMessaging, this._deviceInfoPlugin) {
    // Initialization logic can't use await directly in constructor
    _messagingAutoInit();
  }

  final FirebaseMessaging _firebaseMessaging;
  final DeviceInfoPlugin _deviceInfoPlugin;

  Future<void> _messagingAutoInit() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
  }

  @override
  Future<Either<SomeFailure, DeviceModel?>> getDevice() async {
    late var id = '';
    SomeFailure? failure;
    String? fcm;
    final platform = PlatformEnum.getPlatform;

    final fcmResult = await getFcm();
    fcmResult.fold(
      (l) => failure = l,
      (r) => fcm = r,
    );
    if (failure != null) return Left(failure!);

    final idResult = await getDeviceId();
    idResult.fold(
      (l) => failure = l,
      (r) => id = r,
    );

    return Right(
      DeviceModel(
        deviceId: id,
        fcmToken: fcm,
        date: ExtendedDateTime.current,
        build: '',
        platform: PlatformEnum.android,
      ),
    );
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
    //     } catch (e) {
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
      late String deviceId;
      switch (platform) {
        case PlatformEnum.android:
          final dev = await _deviceInfoPlugin.androidInfo;
          deviceId = dev.id;
        case PlatformEnum.ios:
          final dev = await _deviceInfoPlugin.iosInfo;

          deviceId = dev.identifierForVendor ?? 'unknown';
        case PlatformEnum.web:
          final dev = await _deviceInfoPlugin.webBrowserInfo;

          deviceId = dev.userAgent ?? dev.vendor ?? 'unknown';
        case PlatformEnum.unknown:
          final dev = await _deviceInfoPlugin.deviceInfo;
          deviceId = dev.toString();
      }
      return Right(deviceId);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, String?>> getFcm({
    PlatformEnum? platformValue,
  }) async {
    try {
      final platform = platformValue ?? PlatformEnum.getPlatform;
      String? temp2;
      final notificationSettings =
          await _firebaseMessaging.getNotificationSettings();
      switch (platform) {
        case PlatformEnum.android:
          final dev = await _deviceInfoPlugin.androidInfo;
          temp2 = dev.id;
        case PlatformEnum.ios:
          final dev = await _deviceInfoPlugin.iosInfo;

          temp2 = dev.identifierForVendor ?? 'unknown';
        case PlatformEnum.web:
          final dev = await _deviceInfoPlugin.webBrowserInfo;

          temp2 = dev.userAgent ?? dev.vendor ?? 'unknown';
        case PlatformEnum.unknown:
          final dev = await _deviceInfoPlugin.deviceInfo;
          temp2 = dev.toString();
      }

      /// Do we need this?

      // You may set the permission requests to "provisional" which allows the
      // user to choose what type
      // of notifications they would like to receive once the user receives a
      // notification.
      // final notificationSettings = await FirebaseMessaging.instance.
      // requestPermission(provisional: true);

      // For apple platforms, ensure the APNS token is available before making
      // any FCM plugin API calls
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (!kIsWeb && Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(provisional: true);
      }

      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized &&
          (kIsWeb || !Platform.isIOS || apnsToken != null)) {
        temp2 = await _firebaseMessaging.getToken(
          vapidKey: Config.isProduction
              ? KSecurityKeys.firebaseProdVapidKey
              : KSecurityKeys.firebaseDevVapidKey,
        );
      }
      return Right(temp2);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
