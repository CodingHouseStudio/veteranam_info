import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@Singleton()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.isAnonymouslyOrEmty
              ? const AuthenticationState.unknown()
              : AuthenticationState.authenticated(
                  currentUser: authenticationRepository.currentUser,
                  currentUserSetting:
                      authenticationRepository.currentUserSetting,
                ),
        ) {
    // on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationDeleteRequested>(_onAuthenticationDeleteRequested);
    on<AuthenticationInitialized>(_onAuthenticationInitialized);
    on<_AppUserChanged>(_onUserChanged);
    on<_AppUserSettingChanged>(_onUserSettingChanged);
    on<AppLanguageChanged>(_onAppLanguageChanged);
    on<AppUserRoleChanged>(_onAppUserRoleChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  // late StreamSubscription<AuthenticationStatus>
  //     authenticationStatusSubscription;
  late StreamSubscription<UserSetting> userSettingSubscription;
  late StreamSubscription<User> userSubscription;
  static const String tokenKey = KAppText.authTokenKey;

  @override
  Future<void> close() {
    //authenticationStatusSubscription.cancel();
    userSettingSubscription.cancel();
    userSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  // void _onAuthenticationStatusChanged(
  //   AuthenticationStatusChanged event,
  //   Emitter<AuthenticationState> emit,
  // ) {
  //   log('${KAppText.authChange} ${event.status}');
  //   log('user:_____________ ${_authenticationRepository.currentUser}');
  //   switch (event.status) {
  //     // case AuthenticationStatus.unauthenticated:
  //     //   return emit(const AuthenticationState.unauthenticated());
  //     case AuthenticationStatus.authenticated:
  //       return emit(
  //         AuthenticationState.authenticated(
  //           currentUser: _authenticationRepository.currentUser,
  //           currentUserSetting: _authenticationRepository.currentUserSetting,
  //         ),
  //       );
  //     case AuthenticationStatus.anonymous:
  //       return emit(
  //         AuthenticationState.anonymous(
  //           anonymouslyUser: _authenticationRepository.currentUser,
  //           anonymouslyUserSetting:
  //               _authenticationRepository.currentUserSetting,
  //         ),
  //       );

  //     case AuthenticationStatus.unknown:
  //       return emit(const AuthenticationState.unknown());
  //   }
  // }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.logOut();
  }

  Future<void> _onAuthenticationDeleteRequested(
    AuthenticationDeleteRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.deleteUser();
  }

  void _onAuthenticationInitialized(
    AuthenticationInitialized event,
    Emitter<AuthenticationState> emit,
  ) {
    userSettingSubscription = _authenticationRepository.userSetting
        .listen((userSetting) => add(_AppUserSettingChanged(userSetting)));
    // authenticationStatusSubscription = _authenticationRepository.status.listen(
    //   (status) => add(AuthenticationStatusChanged(status)),
    // );
    userSubscription = _authenticationRepository.user.listen(
      (user) => add(
        _AppUserChanged(user),
      ),
    );
  }

  void _onUserChanged(
    _AppUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    late AuthenticationStatus status;
    if (event.user.isEmpty) {
      status = AuthenticationStatus.unknown;
    } else if (_authenticationRepository.isAnonymouslyOrEmty) {
      status = AuthenticationStatus.anonymous;
    } else {
      status = AuthenticationStatus.authenticated;
    }

    log('${KAppText.authChange} $status');
    log('user:_____________ ${_authenticationRepository.currentUser}');
    switch (status) {
      // case AuthenticationStatus.unauthenticated:
      //   return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(
          AuthenticationState.authenticated(
            currentUser: event.user,
            currentUserSetting: _authenticationRepository.currentUserSetting,
          ),
        );
      case AuthenticationStatus.anonymous:
        return emit(
          AuthenticationState.anonymous(
            anonymouslyUser: event.user,
            anonymouslyUserSetting:
                _authenticationRepository.currentUserSetting,
          ),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
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
    final userSetting = state.userSetting.copyWith(
      locale: state.userSetting.locale.isEnglish
          ? Language.ukrain
          : Language.english,
    );
    add(_AppUserSettingChanged(userSetting));
    if (state.user.hasValue) {
      await _authenticationRepository.updateUserSetting(
        userSetting: userSetting,
      );
    }
  }

  Future<void> _onAppUserRoleChanged(
    AppUserRoleChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (!_authenticationRepository.isAnonymouslyOrEmty) {
      final userSetting = state.userSetting.copyWith(
        userRole: event.userRole,
      );
      add(_AppUserSettingChanged(userSetting));
      await _authenticationRepository.updateUserSetting(
        userSetting: userSetting,
      );
    }
  }
}

extension UserChecker on User? {
  bool get hasValue => this != null && this!.isNotEmpty;
}
