import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

class TitleConverter implements JsonConverter<String, String> {
  const TitleConverter();

  @override
  String fromJson(String json) {
    return json.length > KMinMaxSize.questionsTitleMaxLength
        ? json.substring(0, KMinMaxSize.questionsTitleMaxLength)
        : json;
  }

  @override
  String toJson(String object) {
    return object;
  }
}
