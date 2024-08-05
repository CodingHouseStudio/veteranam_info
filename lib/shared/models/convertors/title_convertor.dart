import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

class TitleConverter implements JsonConverter<String, String> {
  const TitleConverter();

  @override
  String fromJson(String json) {
    return json.setStringLength(KMinMaxSize.titleMaxLength);
  }

  @override
  String toJson(String object) {
    return object.setStringLength(KMinMaxSize.titleMaxLength);
  }
}
