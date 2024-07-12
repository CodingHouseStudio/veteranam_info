import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

class SubtitleConverter implements JsonConverter<String, String> {
  const SubtitleConverter();

  @override
  String fromJson(String json) {
    return json.length > KMinMaxSize.subtitleMaxLength
        ? json.substring(0, KMinMaxSize.subtitleMaxLength)
        : json;
  }

  @override
  String toJson(String object) {
    return object.length > KMinMaxSize.subtitleMaxLength
        ? object.substring(0, KMinMaxSize.subtitleMaxLength)
        : object;
  }
}

/// FOLDER FILES COMMENT: Classes set filtering for getting and adding in json
