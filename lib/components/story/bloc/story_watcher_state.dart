part of 'story_watcher_bloc.dart';

enum StoryFailure {
  error,
}

extension StoryFailureValue on StoryFailure {
  String value(BuildContext context) {
    switch (this) {
      case StoryFailure.error:
        return context.l10n.error;
    }
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
