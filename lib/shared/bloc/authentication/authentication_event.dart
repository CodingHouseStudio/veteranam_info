part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialized extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

final class _AppUserChanged extends AuthenticationEvent {
  const _AppUserChanged(this.user);

  final User user;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
