import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String id,
    required DateTime date,
    required String story,
    required String userName,
    List<ImageModel>? userPhoto,
    List<ImageModel>? image,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
