import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc
    extends Bloc<_AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          AuthenticationState._(
            status: authenticationRepository.currectAuthenticationStatus,
          ),
        ) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationDeleteRequested>(_onAuthenticationDeleteRequested);
    // on<AuthenticationInitialized>(_onAuthenticationInitialized);
    on<_AuthenticationFailureEvent>(_onAuthenticationFailure);
    _onAuthenticationInitialized();
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  static const String tokenKey = KAppText.authTokenKey;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    log('${KAppText.authChange} ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        return emit(
          const AuthenticationState.authenticated(),
        );
      case AuthenticationStatus.anonymous:
        return emit(
          const AuthenticationState.anonymous(),
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

  Future<void> _onAuthenticationDeleteRequested(
    AuthenticationDeleteRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.deleteUser();
  }

  void _onAuthenticationInitialized(
      // AuthenticationInitialized event,
      // Emitter<AuthenticationState> emit,
      ) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
      onError: (Object error, StackTrace stack) =>
          add(_AuthenticationFailureEvent(stack: stack, error: error)),
    );
  }

  void _onAuthenticationFailure(
    _AuthenticationFailureEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      AuthenticationState.failure(
        previousStatus: state.status,
        failure: SomeFailure.value(
          error: event.error,
          stack: event.stack,
          tag: 'Authentication Bloc',
          tagKey: ErrorText.streamBlocKey,
        ),
      ),
    );
  }
}

// extension UserChecker on User? {
//   bool get hasValue => this != null && this!.isNotEmpty;
// }
