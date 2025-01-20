part of 'authentication_bloc.dart';

// extension AuthenticationFailureExtension on SomeFailure {
//   AuthenticationFailure _toAuthentication() {
//     return AuthenticationFailure.error;
//   }
// }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.failure,
  });

  const AuthenticationState.unknown()
      : this._(status: AuthenticationStatus.unknown);

  const AuthenticationState.authenticated()
      : this._(
          status: AuthenticationStatus.authenticated,
        );

  // const AuthenticationState.unauthenticated()
  //     : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.anonymous()
      : this._(
          status: AuthenticationStatus.anonymous,
        );

  const AuthenticationState.failure({
    required SomeFailure failure,
    required AuthenticationStatus previousStatus,
  }) : this._(
          status: previousStatus,
          failure: failure,
        );

  final AuthenticationStatus status;

  final SomeFailure? failure;

  @override
  List<Object> get props => [status];
}
