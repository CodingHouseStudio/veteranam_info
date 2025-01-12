part of 'user_watcher_bloc.dart';

// extension UserWatcherFailureExtension on SomeFailure {
//   UserWatcherFailure _toUserWatcher() {
//     return UserWatcherFailure.error;
//   }
// }

@freezed
class UserWatcherState with _$UserWatcherState {
  const factory UserWatcherState({
    required User user,
    required UserSetting userSetting,
    SomeFailure? failure,
  }) = _Initial;
}
