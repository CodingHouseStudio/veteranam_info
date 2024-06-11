part of 'my_story_watcher_bloc.dart';

enum MyStoryFailure {
  error,
  get,
  network,
}

extension MyStoryFailureValue on MyStoryFailure {
  String value(BuildContext context) {
    switch (this) {
      case MyStoryFailure.error:
        return context.l10n.error;
      case MyStoryFailure.get:
        return context.l10n.getFailure;
      case MyStoryFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension MyStoryFailureExtension on SomeFailure {
  MyStoryFailure toMyStory() {
    switch (this) {
      case FailureGet():
        return MyStoryFailure.get;
      case FailureNetwork():
        return MyStoryFailure.network;
      default:
        return MyStoryFailure.error;
    }
  }
}

@freezed
class MyStoryWatcherState with _$MyStoryWatcherState {
  const factory MyStoryWatcherState({
    required List<StoryModel> storyModelItems,
    required LoadingStatus loadingStatus,
    MyStoryFailure? failure,
  }) = _Initial;
}
