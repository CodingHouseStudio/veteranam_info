part of 'my_story_watcher_bloc.dart';

@freezed
sealed class MyStoryWatcherEvent with _$MyStoryWatcherEvent {
  const factory MyStoryWatcherEvent.started() = _Started;
}
