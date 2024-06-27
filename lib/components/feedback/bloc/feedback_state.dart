part of 'feedback_bloc.dart';

enum FeedbackFailure {
  error,
  network,
  send,
}

extension FeedbackFailureExtension on SomeFailure {
  FeedbackFailure _toFeedback() {
    switch (this) {
      case FailureSend():
        return FeedbackFailure.send;
      case FailureNetwork():
        return FeedbackFailure.network;
      default:
        return FeedbackFailure.error;
    }
  }
}

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    required NameFieldModel name,
    required EmailFieldModel email,
    required MessageFieldModel message,
    required FeedbackEnum formState,
    required FeedbackFailure? failure,
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
