import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
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
    late String id;
    late SomeFailure? failure;
    late String? fcm;

    final idResult = await getDeviceId();
    idResult.fold(
      (l) => failure = l,
      (r) => id = r,
    );
    if (failure != null) return Left(failure!);

    final fcmResult = await getFcm();
    fcmResult.fold(
      (l) => failure = l,
      (r) => fcm = r,
    );
    if (failure != null) return Left(failure!);

    return Right(DeviceModel(deviceId: id, fcmToken: fcm));
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
  Future<Either<SomeFailure, String>> getDeviceId() async {
    try {
      late String deviceId;
      if (Platform.isAndroid) {
        final dev = await _deviceInfoPlugin.androidInfo;
        deviceId = dev.id;
      } else if (Platform.isIOS) {
        final dev = await _deviceInfoPlugin.iosInfo;

        deviceId = dev.identifierForVendor ?? 'unknown';
      } else {
        final dev = await _deviceInfoPlugin.webBrowserInfo;

        deviceId = dev.userAgent ?? dev.vendor ?? 'unknown';
      }
      return Right(deviceId);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, String?>> getFcm() async {
    try {
      String? temp2;
      final notificationSettings =
          await _firebaseMessaging.getNotificationSettings();

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
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission(provisional: true);
      }

      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized &&
          (!Platform.isIOS || apnsToken != null)) {
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
