part of 'user_watcher_bloc.dart';

// extension UserWatcherFailureExtension on SomeFailure {
//   UserWatcherFailure _toUserWatcher() {
//     return UserWatcherFailure.error;
//   }
// }

class UserWatcherState extends Equatable {
  const UserWatcherState({
    required this.user,
    required this.userSetting,
    this.failure,
  });

  final User user;
  final UserSetting userSetting;
  final SomeFailure? failure;

  @override
  List<Object?> get props => [user, userSetting, failure];
  UserWatcherState copyWith({
    User? user,
    UserSetting? userSetting,
  }) =>
      UserWatcherState(
        user: user ?? this.user,
        userSetting: userSetting ?? this.userSetting,
        failure: failure,
      );
}
