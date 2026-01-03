import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/constants/enum.dart';

part 'device_info_model.freezed.dart';
part 'device_info_model.g.dart';

@freezed
abstract class DeviceInfoModel with _$DeviceInfoModel {
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

abstract class DeviceInfoModelJsonField {
  static const deviceId = 'deviceId';
  static const fcmToken = 'fcmToken';
  static const date = 'date';
  static const build = 'build';
  static const platform = 'platform';
}
