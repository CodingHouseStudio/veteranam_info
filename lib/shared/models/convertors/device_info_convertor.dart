import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

class DeviceConverter
    implements JsonConverter<List<DeviceInfoModel>?, List<dynamic>?> {
  const DeviceConverter();

  @override
  List<DeviceInfoModel>? fromJson(List<dynamic>? json) {
    final list = json == null
        ? null
        : List.generate(
            json.length,
            (index) => DeviceInfoModel?.fromJson(
              json.elementAt(index) as Map<String, dynamic>,
            ),
          );
    if (list?.isEmpty ?? true) {
      return null;
    } else {
      return list;
    }
  }

  @override
  List<dynamic>? toJson(List<DeviceInfoModel>? object) {
    return object == null
        ? null
        : List.generate(
            object.length,
            (index) => object.elementAt(index).toJson(),
            growable: false,
          );
  }
}
