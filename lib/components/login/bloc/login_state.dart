part of 'login_bloc.dart';

enum LoginError {
  none,
  error,
  initial,
}

extension AuthFailureToLoginError on SomeFailure {
  LoginError toLogInError() {
    return LoginError.error;
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required LoginError failure,
    required FieldEnum fieldsState,
    required bool showPassword,
  }) = _LoginState;
}
