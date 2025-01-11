part of 'story_watcher_bloc.dart';

@freezed
class StoryWatcherEvent with _$StoryWatcherEvent {
  const factory StoryWatcherEvent.started() = _Started;

  const factory StoryWatcherEvent.updated(
    List<StoryModel> storyItemsModel,
  ) = _Updated;

  const factory StoryWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory StoryWatcherEvent.failure({
    required Object error,
    required StackTrace stack,
  }) = _Failure;
}
