part of 'story_add_bloc.dart';

enum StoryAddFailure { error }

extension StoryAddFailureExtension on SomeFailure {
  StoryAddFailure toStoryAdd() {
    return StoryAddFailure.error;
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
