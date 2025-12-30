import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/extension/extension_dart.dart';

class SubtitleConverter implements JsonConverter<String, dynamic> {
  const SubtitleConverter();

  @override
  String fromJson(dynamic json) {
    final text = json as String;
    return text.setStringLength(KMinMaxSize.subtitleMaxLength);
  }

  @override
  dynamic toJson(String object) {
    return object;
  }
}

/// FOLDER FILES COMMENT: Classes set filtering for getting and adding in json
