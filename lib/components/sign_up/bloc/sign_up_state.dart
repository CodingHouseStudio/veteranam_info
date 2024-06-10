part of 'sign_up_bloc.dart';

enum SignUpError {
  duplicate,
  error,
  network,
  send,
}

extension SignUpFailureValue on SignUpError {
  String value(BuildContext context) {
    switch (this) {
      case SignUpError.error:
        return context.l10n.error;
      case SignUpError.send:
        return context.l10n.sendFailure;
      case SignUpError.network:
        return context.l10n.networkFailure;
      case SignUpError.duplicate:
        return context.l10n.dublicateFailure;
    }
  }
}

extension AuthFailureToSignUpError on SomeFailure {
  SignUpError toSignUpError() {
    switch (this) {
      case FailureDuplicate():
        return SignUpError.duplicate;
      case FailureSend():
        return SignUpError.send;
      case FailureNetwork():
        return SignUpError.network;
      default:
        return SignUpError.error;
    }
  }
}

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required SignUpError? failure,
    required bool? fieldsIsCorrect,
    required bool showPasswordField,
  }) = _SignUpState;
}
