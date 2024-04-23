part of 'login_bloc.dart';

enum LoginError {
  none,
  error,
  notFound,
  initial,
}

extension AuthFailureToLoginError on SomeFailure {
  LoginError toLogInError() {
    switch (this) {
      case FailureNotFound():
        return LoginError.notFound;
      default:
        return LoginError.error;
    }
  }
}

extension LoginErrorExtention on LoginError {
  String? getString(BuildContext context) {
    switch (this) {
      case LoginError.error:
        return context.l10n.serverError;
      case LoginError.notFound:
        return context.l10n.notFound;
      case LoginError.none:
      case LoginError.initial:
        return null;
    }
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required LoginError failure,
    required bool? fieldsIsCorrect,
    required bool showPasswordField,
  }) = _LoginState;
}
