import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'user_watcher_event.dart';
part 'user_watcher_state.dart';
part 'user_watcher_bloc.freezed.dart';

@injectable
class UserWatcherBloc extends Bloc<UserWatcherEvent, UserWatcherState> {
  UserWatcherBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(
          const _Initial(user: User.empty, userSetting: UserSetting.empty),
        ) {
    on<_UserChanged>(_onUserChanged);
    on<_UserSettingChanged>(_onUserSettingChanged);
    on<_UserFailure>(_onUserFailure);
    on<_UserSettingFailure>(_onUserSettingFailure);
    _onStarted();
  }
  late StreamSubscription<UserSetting> userSettingSubscription;
  late StreamSubscription<User> userSubscription;
  final UserRepository _userRepository;
  void _onStarted() {
    userSettingSubscription = _userRepository.userSetting.listen(
      (userSetting) => add(UserWatcherEvent.userSettingChanged(userSetting)),
    );
    userSubscription = _userRepository.user.listen(
      (user) => add(UserWatcherEvent.userChanged(user)),
    );
  }

  void _onUserChanged(
    _UserChanged event,
    Emitter<UserWatcherState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void _onUserSettingChanged(
    _UserSettingChanged event,
    Emitter<UserWatcherState> emit,
  ) {
    emit(state.copyWith(userSetting: event.userSetting));
  }

  void _onUserFailure(
    _UserFailure event,
    Emitter<UserWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        failure: SomeFailure.serverError(
          error: event.error,
          stack: event.stack,
          tag: 'User ${ErrorText.watcherBloc}',
          tagKey: 'User ${ErrorText.streamBlocKey}',
        )._toUserWatcher(),
      ),
    );
  }

  void _onUserSettingFailure(
    _UserSettingFailure event,
    Emitter<UserWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        failure: SomeFailure.serverError(
          error: event.error,
          stack: event.stack,
          tag: 'User ${ErrorText.watcherBloc}',
          tagKey: 'User Setting ${ErrorText.streamBlocKey}',
        )._toUserWatcher(),
      ),
    );
  }

  @override
  Future<void> close() {
    userSettingSubscription.cancel();
    userSubscription.cancel();
    _userRepository.dispose();
    return super.close();
  }
}
