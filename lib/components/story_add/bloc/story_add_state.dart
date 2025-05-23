part of 'story_add_bloc.dart';

// extension StoryAddFailureExtension on SomeFailure {
//   StoryAddFailure _toStoryAdd() {
//     switch (this) {
//       case FailureSend():
//         return StoryAddFailure.send;
//       case FailureNetwork():
//         return StoryAddFailure.network;
//       default:
//         return StoryAddFailure.error;
//     }
//   }
// }

@freezed
sealed class StoryAddState with _$StoryAddState {
  const factory StoryAddState({
    required MessageFieldModel story,
    required ImageFieldModel image,
    required bool isAnonymously,
    required FormzSubmissionStatus formStatus,
    required SomeFailure? failure,
  }) = _Initial;
}
