part of 'story_watcher_bloc.dart';

extension StoryFailureExtension on SomeFailure {
  StoryFailure _toStory() {
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
    required bool isListLoadedFull,
  }) = _Initial;
}
