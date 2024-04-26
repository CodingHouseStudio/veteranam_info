part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.userSetting = UserSetting.empty,
  });

  const AuthenticationState.unknown() : this._(userSetting: UserSetting.empty);

  const AuthenticationState.authenticated({
    required User currentUser,
    required UserSetting currentUserSetting,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          user: currentUser,
          userSetting: currentUserSetting,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserSetting? userSetting,
    User? user,
  }) {
    return AuthenticationState._(
      status: status ?? this.status,
      userSetting: userSetting ?? this.userSetting,
      user: user ?? this.user,
    );
  }

  final AuthenticationStatus status;
  final UserSetting userSetting;
  final User? user;

  @override
  List<Object> get props => [status, userSetting];
}
