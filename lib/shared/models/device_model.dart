import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required String deviceId,
    required String? fcmToken,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  static const empty = DeviceModel(deviceId: '', fcmToken: null);

  bool get isEmpty => this == DeviceModel.empty;
}

abstract class DeviceModelJsonField {
  static const deviceId = 'deviceId';
  static const fcmToken = 'fcmToken';
}
