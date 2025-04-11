import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
abstract class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required DateTime date,
    @SubtitleConverter() required String story,
    required String userId,
    String? userName,
    @ImageConverter() ImageModel? userPhoto,
    @ImageConverter() ImageModel? image,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

abstract class StoryModelJsonField {
  static const id = 'id';
  static const date = 'date';
  static const story = 'story';
  static const userId = 'userId';
  static const userName = 'userName';
  static const userPhoto = 'userPhoto';
  static const image = 'image';
}
