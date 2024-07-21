import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

class TitleConverter implements JsonConverter<String, String> {
  const TitleConverter();

  @override
  String fromJson(String json) {
    return json.length > KMinMaxSize.titleMaxLength
        ? json.substring(0, KMinMaxSize.titleMaxLength)
        : json;
  }

  @override
  String toJson(String object) {
    return object.length > KMinMaxSize.titleMaxLength
        ? object.substring(0, KMinMaxSize.titleMaxLength)
        : object;
  }
}
