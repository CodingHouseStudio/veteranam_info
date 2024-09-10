import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

class ImageMemoryConverter
    implements JsonConverter<Uint8List?, List<dynamic>?> {
  const ImageMemoryConverter();

  @override
  Uint8List? fromJson(List<dynamic>? json) {
    return null;
  }

  @override
  List<dynamic>? toJson(Uint8List? object) {
    return null;
  }
}
