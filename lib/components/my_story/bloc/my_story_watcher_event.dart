part of 'my_story_watcher_bloc.dart';

@freezed
class MyStoryWatcherEvent with _$MyStoryWatcherEvent {
  const factory MyStoryWatcherEvent.started() = _Started;
}
