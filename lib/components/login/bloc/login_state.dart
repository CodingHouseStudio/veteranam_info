part of 'login_bloc.dart';

enum LoginFailure {
  error,
  notFound,
  network,
  send,
}

extension AuthFailureToLoginFailure on SomeFailure {
  LoginFailure _toLogInError() {
    switch (this) {
      case FailureSend():
        return LoginFailure.send;
      case FailureNotFound():
        return LoginFailure.notFound;
      case FailureNetwork():
        return LoginFailure.network;
      default:
        return LoginFailure.error;
    }
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required LoginFailure? failure,
    required LoginEnum formState,
  }) = _LoginState;
}

enum LoginEnum {
  initial,
  showPassword,
  inProgress,
  invalidData,
  passwordInProgress,
  passwordInvalidData,
  // loginLoading,
  success
}
