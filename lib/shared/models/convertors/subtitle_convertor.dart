import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

class SubtitleConverter implements JsonConverter<String, String> {
  const SubtitleConverter();

  @override
  String fromJson(String json) {
    return json.setStringLength(KMinMaxSize.subtitleMaxLength);
  }

  @override
  String toJson(String object) {
    return object.setStringLength(KMinMaxSize.subtitleMaxLength);
  }
}

/// FOLDER FILES COMMENT: Classes set filtering for getting and adding in json
