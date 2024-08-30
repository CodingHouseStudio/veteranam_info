import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

class DeviceConverter
    implements JsonConverter<List<DeviceInfoModel?>?, List<dynamic>?> {
  const DeviceConverter();

  @override
  List<DeviceInfoModel?>? fromJson(List<dynamic>? json) {
    final list = json
        ?.map((e) => DeviceInfoModel?.fromJson(e as Map<String, dynamic>))
        .toList();
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      return list;
    }
  }

  @override
  List<dynamic>? toJson(List<DeviceInfoModel?>? object) {
    return object
        ?.map(
          (e) => e?.toJson(),
        )
        .toList();
  }
}
