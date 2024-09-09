part of 'login_bloc.dart';

enum LoginError {
  error,
  notFound,
  network,
  send,
}

extension AuthFailureToLoginError on SomeFailure {
  LoginError _toLogInError() {
    switch (this) {
      case FailureSend():
        return LoginError.send;
      case FailureNotFound():
        return LoginError.notFound;
      case FailureNetwork():
        return LoginError.network;
      default:
        return LoginError.error;
    }
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required LoginError? failure,
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
}
