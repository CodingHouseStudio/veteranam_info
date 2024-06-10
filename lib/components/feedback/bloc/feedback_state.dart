part of 'feedback_bloc.dart';

enum FeedbackFailure {
  error,
  network,
  send,
}

extension FeedbackFailureValue on FeedbackFailure {
  String value(BuildContext context) {
    switch (this) {
      case FeedbackFailure.error:
        return context.l10n.error;
      case FeedbackFailure.send:
        return context.l10n.sendFailure;
      case FeedbackFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension FeedbackFailureExtension on SomeFailure {
  FeedbackFailure toFeedback() {
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
