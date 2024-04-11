part of 'feedback_bloc.dart';

enum FeedbackEnum {
  initial,
  inProgress,
  success,
  invalidData,
}

enum FeedbackFailure {
  none,
  error,
  initial,
}

extension FeedbackFailureExtension on SomeFailure {
  FeedbackFailure toFeedback() {
    return FeedbackFailure.error;
  }
}

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    required NameFieldModel name,
    required EmailFieldModel email,
    required MessageFieldModel message,
    required FeedbackEnum fieldsState,
    required FeedbackFailure failure,
  }) = _FeedbackState;
}
