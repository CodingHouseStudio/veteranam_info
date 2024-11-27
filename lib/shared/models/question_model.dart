import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String id,
    // ignore: invalid_annotation_target
    @JsonKey(readValue: TranslateConverter.readJsonItem)
    @TitleConverter()
    required TranslateModel title,
    // ignore: invalid_annotation_target
    @JsonKey(readValue: TranslateConverter.readJsonItem)
    @SubtitleConverter()
    required TranslateModel subtitle,
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
