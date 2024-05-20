import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

class ImageConverter
    implements JsonConverter<List<ImageModel>?, List<dynamic>?> {
  const ImageConverter();

  @override
  List<ImageModel>? fromJson(List<dynamic>? json) {
    return json
        ?.map((e) => ImageModel?.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic>? toJson(List<ImageModel>? object) {
    return object?.map((e) => e.toJson()).toList();
  }
}
