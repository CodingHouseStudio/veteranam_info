part of 'story_watcher_bloc.dart';

enum StoryFailure {
  error,
}

extension StoryFailureExtension on SomeFailure {
  StoryFailure toStory() {
    return StoryFailure.error;
  }
}

@freezed
class StoryWatcherState with _$StoryWatcherState {
  const factory StoryWatcherState({
    required List<StoryModel> storyModelItems,
    required List<StoryModel> loadingStoryModelItems,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required StoryFailure? failure,
  }) = _Initial;
}
