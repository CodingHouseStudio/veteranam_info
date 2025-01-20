part of 'authentication_bloc.dart';

class _AuthenticationEvent extends Equatable {
  const _AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// class AuthenticationInitialized extends AuthenticationEvent {}

class _AuthenticationStatusChanged extends _AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class _AuthenticationFailureEvent extends _AuthenticationEvent {
  const _AuthenticationFailureEvent({required this.stack, required this.error});

  final Object error;
  final StackTrace stack;

  @override
  List<Object> get props => [stack, error];
}

class AuthenticationLogoutRequested extends _AuthenticationEvent {}

class AuthenticationDeleteRequested extends _AuthenticationEvent {}
