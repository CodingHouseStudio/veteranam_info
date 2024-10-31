import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'information_model.freezed.dart';
part 'information_model.g.dart';

@freezed
class InformationModel with _$InformationModel {
  const factory InformationModel({
    required String id,
    required String title,
    required String news,
    required List<String> category,
    required List<String> categoryUA,
    required String topic,
    required String topicUA,
    required String status,
    required DateTime fetchDate,
    required int? likes,
    @ImageConverter() ImageModel? image,
  }) = _InformationModel;

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);
}

abstract class InformationModelJsonField {
  static const id = 'id';
  static const title = 'title';
  static const news = 'news';
  static const fetchDate = 'fetchDate';
  static const category = 'category';
  static const categoryUA = 'categoryUA';
  static const topic = 'topic';
  static const topicUA = 'topicUA';
  static const status = 'status';
  static const image = 'image';
  static const likes = 'likes';
}
