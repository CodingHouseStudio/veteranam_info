part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// class AuthenticationInitialized extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationFailureEvent extends AuthenticationEvent {
  const AuthenticationFailureEvent({required this.stack, required this.error});

  final Object error;
  final StackTrace stack;

  @override
  List<Object> get props => [stack, error];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationDeleteRequested extends AuthenticationEvent {}
