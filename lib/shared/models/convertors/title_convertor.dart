import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:veteranam/shared/constants/dimensions/min_max_size_constants.dart';
import 'package:veteranam/shared/extension/extension_dart_constants.dart';

class TitleConverter implements JsonConverter<String, dynamic> {
  const TitleConverter();

  @override
  String fromJson(dynamic json) {
    final value = json as String;
    return value.setStringLength(KMinMaxSize.titleMaxLength);
  }

  @override
  dynamic toJson(String object) {
    return object.setStringLength(KMinMaxSize.titleMaxLength);
  }
}
