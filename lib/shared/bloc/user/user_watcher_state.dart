part of 'user_watcher_bloc.dart';

@freezed
class UserWatcherState with _$UserWatcherState {
  const factory UserWatcherState({
    required User user,
    required UserSetting userSetting,
  }) = _Initial;
}
