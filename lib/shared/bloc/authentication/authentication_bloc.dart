import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@Singleton()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  currentUser: authenticationRepository.currentUser,
                  currentUserSetting:
                      authenticationRepository.currentUserSetting,
                )
              : const AuthenticationState.unknown(),
        ) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationInitialized>(_onAuthenticationInitialized);
    on<_AppUserChanged>(_onUserChanged);
    on<_AppUserSettingChanged>(_onUserSettingChanged);
    on<AppLanguageChanged>(_onAppLanguageChanged);
    on<AppUserRoleChanged>(_onAppUserRoleChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      authenticationStatusSubscription;
  late StreamSubscription<UserSetting> userSettingSubscription;
  static const String tokenKey = KAppText.authTokenKey;

  @override
  Future<void> close() {
    authenticationStatusSubscription.cancel();
    userSettingSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    log('${KAppText.authChange} ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(
          AuthenticationState.authenticated(
            currentUser: _authenticationRepository.currentUser,
            currentUserSetting: _authenticationRepository.currentUserSetting,
          ),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.logOut();
  }

  Future<void> _onAuthenticationInitialized(
    AuthenticationInitialized event,
    Emitter<AuthenticationState> emit,
  ) async {
    authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
    userSettingSubscription =
        _authenticationRepository.userSettingStream.listen(
      (userSetting) => add(_AppUserSettingChanged(userSetting)),
    );
  }

  void _onUserChanged(
    _AppUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      AuthenticationState.authenticated(
        currentUser: event.user,
        currentUserSetting: state.userSetting,
      ),
    );
  }

  void _onUserSettingChanged(
    _AppUserSettingChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      state.copyWith(
        userSetting: event.userSetting,
      ),
    );
  }

  Future<void> _onAppLanguageChanged(
    AppLanguageChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    late var userSetting = state.userSetting.copyWith(
      locale: event.language,
    );
    if (state.user != null) {
      userSetting = userSetting.copyWith(
        id: state.user!.id,
      );
      await _authenticationRepository.updateUserSetting(
        userSetting: userSetting,
      );
    }
    emit(
      state.copyWith(
        userSetting: userSetting,
      ),
    );
  }

  Future<void> _onAppUserRoleChanged(
    AppUserRoleChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.user != null) {
      final userSetting = state.userSetting.copyWith(
        id: state.user!.id,
        userRole: event.userRole,
      );
      await _authenticationRepository.updateUserSetting(
        userSetting: userSetting,
      );
      emit(
        state.copyWith(
          userSetting: userSetting,
        ),
      );
    }
  }
}
