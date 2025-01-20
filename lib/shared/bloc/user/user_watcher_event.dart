part of 'user_watcher_bloc.dart';

class _UserWatcherEvent extends Equatable {
  const _UserWatcherEvent();

  @override
  List<Object> get props => [];
}

class _UserChangedEvent extends _UserWatcherEvent {
  const _UserChangedEvent(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class _UserSettingChangedEvent extends _UserWatcherEvent {
  const _UserSettingChangedEvent(this.userSetting);

  final UserSetting userSetting;

  @override
  List<Object> get props => [userSetting];
}

class LanguageChangedEvent extends _UserWatcherEvent {
  const LanguageChangedEvent();

  @override
  List<Object> get props => const [];
}

class _UserFailureEvent extends _UserWatcherEvent {
  const _UserFailureEvent({
    required this.error,
    required this.stack,
  });

  final Object error;
  final StackTrace stack;

  @override
  List<Object> get props => [error, stack];
}

class _UserSettingFailureEvent extends _UserWatcherEvent {
  const _UserSettingFailureEvent({
    required this.error,
    required this.stack,
  });

  final Object error;
  final StackTrace stack;

  @override
  List<Object> get props => [error, stack];
}
