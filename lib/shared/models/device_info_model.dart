import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_model.freezed.dart';
part 'device_info_model.g.dart';

@freezed
class DeviceInfoModel with _$DeviceInfoModel {
  const factory DeviceInfoModel({
    required String deviceId,
    required DateTime date,
    required String build,
    required PlatformEnum platform,
    required String? fcmToken,
  }) = _DeviceInfoModel;

  // Add this private constructor
  const DeviceInfoModel._();

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoModelFromJson(json);

  bool get isEmpty => fcmToken == null || fcmToken!.isEmpty;
}

enum PlatformEnum {
  android,
  ios,
  web,
  unknown;

  bool get isAndroid => this == PlatformEnum.android;
  bool get isIOS => this == PlatformEnum.ios;
  bool get isWeb => this == PlatformEnum.web;
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

abstract class DeviceInfoModelJsonField {
  static const deviceId = 'deviceId';
  static const fcmToken = 'fcmToken';
  static const date = 'date';
  static const build = 'build';
  static const platform = 'platform';
}
