import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@Singleton()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          AuthenticationState._(
            status: authenticationRepository.currectAuthenticationStatus,
          ),
        ) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationDeleteRequested>(_onAuthenticationDeleteRequested);
    // on<AuthenticationInitialized>(_onAuthenticationInitialized);
    on<AuthenticationFailureEvent>(_onAuthenticationFailure);
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
    AuthenticationStatusChanged event,
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
      (status) => add(AuthenticationStatusChanged(status)),
      onError: (Object error, StackTrace stack) =>
          add(AuthenticationFailureEvent(stack: stack, error: error)),
    );
  }

  void _onAuthenticationFailure(
    AuthenticationFailureEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      AuthenticationState._(
        status: state.status,
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

extension UserChecker on User? {
  bool get hasValue => this != null && this!.isNotEmpty;
}
