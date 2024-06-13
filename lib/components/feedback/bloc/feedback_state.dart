part of 'feedback_bloc.dart';

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
    required FeedbackEnum formState,
    required FeedbackFailure failure,
  }) = _FeedbackState;
}

enum FeedbackEnum {
  initial,
  clear,
  inProgress,
  sendingMessage,
  sendignMessageAgain,
  success,
  invalidData,
  notShowFeedback
}
