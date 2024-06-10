part of 'login_bloc.dart';

enum LoginError {
  error,
  notFound,
  network,
  send,
}

extension LoginFailureValue on LoginError {
  String value(BuildContext context) {
    switch (this) {
      case LoginError.error:
        return context.l10n.error;
      case LoginError.send:
        return context.l10n.sendFailure;
      case LoginError.network:
        return context.l10n.networkFailure;
      case LoginError.notFound:
        return context.l10n.notFoundFailure;
    }
  }
}

extension AuthFailureToLoginError on SomeFailure {
  LoginError toLogInError() {
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
    required bool? fieldsIsCorrect,
    required bool showPasswordField,
  }) = _LoginState;
}
