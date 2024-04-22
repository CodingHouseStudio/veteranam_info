import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:kozak/shared/shared.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// ignore: flutter_style_todos
/// TODO: need to fix user state. now is getting null value
@Singleton()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationRepository.currentUser,
                )
              : const AuthenticationState.unknown(),
        ) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationInitialized>(_onAuthenticationInitialized);
    on<_AppUserChanged>(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      authenticationStatusSubscription;
  static const String tokenKey = KAppText.authTokenKey;

  @override
  Future<void> close() {
    authenticationStatusSubscription.cancel();
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
            _authenticationRepository.currentUser,
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
  }

  void _onUserChanged(
    _AppUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      AuthenticationState.authenticated(_authenticationRepository.currentUser),
    );
  }
}
