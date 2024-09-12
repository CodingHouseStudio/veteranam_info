import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String id,
    @TitleConverter() required String title,
    @TitleConverter() required String titleEN,
    @SubtitleConverter() required String subtitle,
    @SubtitleConverter() required String subtitleEN,
    // String? navigationLink,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

abstract class QuestionModelJsonField {
  static const id = 'id';
  static const title = 'title';
  static const titleEN = 'titleEN';
  static const subtitle = 'subtitle';
  static const subtitleEN = 'subtitleEN';
  // static const navigationLink = 'navigationLink';
}
