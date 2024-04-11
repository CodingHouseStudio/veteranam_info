import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

class SubtitleConverter implements JsonConverter<String, String> {
  const SubtitleConverter();

  @override
  String fromJson(String json) {
    return json.length > KMinMaxSize.questionsSubtitleMaxLength
        ? json.substring(0, KMinMaxSize.questionsSubtitleMaxLength)
        : json;
  }

  @override
  String toJson(String object) {
    return object;
  }
}
