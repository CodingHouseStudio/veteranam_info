import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'information_model.freezed.dart';
part 'information_model.g.dart';

@freezed
class InformationModel with _$InformationModel {
  const factory InformationModel({
    required String id,
    required String title,
    required String news,
    required DateTime date,
    @Default(<String>[]) List<String>? tags,
    @ImageConverter() List<ImageModel>? image,
  }) = _InformationModel;

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);
}

abstract class InformationModelJsonField {
  static const id = 'id';
  static const title = 'title';
  static const news = 'news';
  static const date = 'date';
  static const tags = 'tags';
  static const image = 'image';
}
