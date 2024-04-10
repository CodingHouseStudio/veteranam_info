part of 'feedback_bloc.dart';

enum FeedbackEnum {
  initial,
  error,
  inProgress,
  success,
  invalidData,
}

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    required NameFieldModel name,
    required EmailFieldModel email,
    required MessageFieldModel message,
    required FeedbackEnum fieldsState,
  }) = _FeedbackState;
}
