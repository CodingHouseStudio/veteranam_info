import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/extension/extension_dart.dart';

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
