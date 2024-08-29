import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required String deviceId,
    required DateTime date,
    required String build,
    required PlatformEnum platform,
    required String? fcmToken,
  }) = _DeviceModel;

  // Add this private constructor
  const DeviceModel._();

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  // static const empty = DeviceModel(deviceId: '', fcmToken: null);

  bool get isEmpty => fcmToken == null || fcmToken!.isEmpty;
}

enum PlatformEnum {
  android,
  ios,
  web,
  unknown;

  bool get isAndroid => this == PlatformEnum.android;
  bool get isIOS => this == PlatformEnum.ios;
  bool get isWeb => this == PlatformEnum.android;
  bool get isUnkown => this == PlatformEnum.unknown;

  static PlatformEnum get getPlatform {
    try {
      if (kIsWeb) {
        return PlatformEnum.web;
      } else if (Platform.isAndroid) {
        return PlatformEnum.android;
      } else if (Platform.isIOS) {
        return PlatformEnum.ios;
      }
      return PlatformEnum.unknown;
    } catch (e) {
      return PlatformEnum.unknown;
    }
  }
}

abstract class DeviceModelJsonField {
  static const deviceId = 'deviceId';
  static const fcmToken = 'fcmToken';
}
