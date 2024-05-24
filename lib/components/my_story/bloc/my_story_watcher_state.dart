part of 'my_story_watcher_bloc.dart';

enum MyStoryFailure {
  error,
}

extension MyStoryFailureExtension on SomeFailure {
  MyStoryFailure toMyStory() {
    return MyStoryFailure.error;
  }
}

@freezed
class MyStoryWatcherState with _$MyStoryWatcherState {
  const factory MyStoryWatcherState.initial() = MyStoryWatcherStateInitial;
  const factory MyStoryWatcherState.loading() = MyStoryWatcherStateLoading;
  const factory MyStoryWatcherState.success({
    required List<StoryModel> storyModelItems,
  }) = MyStoryWatcherStateSuccess;
  const factory MyStoryWatcherState.failure(MyStoryFailure failure) =
      MyStoryWatcherStateFailure;
}
