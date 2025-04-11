import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
abstract class ImageModel with _$ImageModel {
  const factory ImageModel({
    required String downloadURL,
    int? lastModifiedTS,
    String? name,
    String? ref,
    String? type,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}

abstract class ImageModelJsonField {
  static const downloadURL = 'downloadURL';
  static const lastModifiedTS = 'lastModifiedTS';
  static const name = 'name';
  static const ref = 'ref';
  static const type = 'type';
}
