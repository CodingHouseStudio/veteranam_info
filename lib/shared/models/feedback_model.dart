import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

enum FeedbackStatus {
  isNew,
  responseRequired,
  resolved,
  ideas,
}

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required String id,
    required String guestId,
    required String guestName,
    required String email,
    required DateTime timestamp,
    required String message,
    @Default(FeedbackStatus.isNew) FeedbackStatus status,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
}
