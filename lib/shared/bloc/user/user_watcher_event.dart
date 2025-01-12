part of 'user_watcher_bloc.dart';

@freezed
class UserWatcherEvent with _$UserWatcherEvent {
  // const factory UserWatcherEvent.started() = _Started;
  const factory UserWatcherEvent.userChanged(User user) = _UserChanged;
  const factory UserWatcherEvent.userSettingChanged(UserSetting userSetting) =
      _UserSettingChanged;
  const factory UserWatcherEvent.userFailure({
    required Object error,
    required StackTrace stack,
  }) = _UserFailure;
  const factory UserWatcherEvent.userSettingFailure({
    required Object error,
    required StackTrace stack,
  }) = _UserSettingFailure;
}
