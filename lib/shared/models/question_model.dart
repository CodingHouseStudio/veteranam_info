import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'question_model.freezed.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String id,
    required String title,
    required String subtitle,
    String? navigationLink,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionModelImpl(
      id: json['id'] as String,
      title:
          (json['title'] as String).length > KMinMaxSize.questionsTitleMaxLength
              ? (json['title'] as String)
                  .substring(0, KMinMaxSize.questionsTitleMaxLength)
              : json['title'] as String,
      subtitle: (json['subtitle'] as String).length >
              KMinMaxSize.questionsSubtitleMaxLength
          ? (json['subtitle'] as String)
              .substring(0, KMinMaxSize.questionsSubtitleMaxLength)
          : json['subtitle'] as String,
      navigationLink: json['navigationLink'] as String?,
    );
  }
}
