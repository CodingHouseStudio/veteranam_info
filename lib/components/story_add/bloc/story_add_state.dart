part of 'story_add_bloc.dart';

enum StoryAddFailure {
  error,
  network,
  send,
}

extension StoryAddFailureValue on StoryAddFailure {
  String value(BuildContext context) {
    switch (this) {
      case StoryAddFailure.error:
        return context.l10n.error;
      case StoryAddFailure.send:
        return context.l10n.sendFailure;
      case StoryAddFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension StoryAddFailureExtension on SomeFailure {
  StoryAddFailure toStoryAdd() {
    switch (this) {
      case FailureSend():
        return StoryAddFailure.send;
      case FailureNetwork():
        return StoryAddFailure.network;
      default:
        return StoryAddFailure.error;
    }
  }
}

@freezed
class StoryAddState with _$StoryAddState {
  const factory StoryAddState({
    required MessageFieldModel story,
    required ImageFieldModel image,
    required bool isAnonymously,
    required FormzSubmissionStatus formStatus,
    required StoryAddFailure? failure,
  }) = _Initial;
}
