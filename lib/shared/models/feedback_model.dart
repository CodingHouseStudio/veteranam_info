import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/models/models.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

enum FeedbackStatus {
  isNew,
  responseRequired,
  resolved,
  ideas,
}

@freezed
abstract class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required String id,
    required String guestId,
    required String? guestName,
    required String email,
    required DateTime timestamp,
    required String message,
    @ImageConverter() ImageModel? image,
    @Default(FeedbackStatus.isNew) FeedbackStatus status,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
}

abstract class FeedbackModelJsonField {
  static const id = 'id';
  static const guestId = 'guestId';
  static const guestName = 'guestName';
  static const email = 'email';
  static const timestamp = 'timestamp';
  static const message = 'message';
  static const status = 'status';
  static const image = 'image';
}
