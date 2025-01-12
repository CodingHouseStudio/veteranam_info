part of 'my_story_watcher_bloc.dart';

// extension MyStoryFailureExtension on SomeFailure {
//   MyStoryFailure _toMyStory() {
//     switch (this) {
//       case FailureGet():
//         return MyStoryFailure.get;
//       case FailureNetwork():
//         return MyStoryFailure.network;
//       default:
//         return MyStoryFailure.error;
//     }
//   }
// }

@freezed
class MyStoryWatcherState with _$MyStoryWatcherState {
  const factory MyStoryWatcherState({
    required List<StoryModel> storyModelItems,
    required LoadingStatus loadingStatus,
    SomeFailure? failure,
  }) = _Initial;
}
