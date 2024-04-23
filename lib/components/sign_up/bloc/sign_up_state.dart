part of 'sign_up_bloc.dart';

enum SignUpError {
  duplicate,
  error,
  initial,
  notFound,
  none,
}

extension AuthFailureToSignUpError on SomeFailure {
  SignUpError toSignUpError() {
    switch (this) {
      case FailureDuplicate():
        return SignUpError.duplicate;
      case FailureNotFound():
        return SignUpError.notFound;
      default:
        return SignUpError.error;
    }
  }
}

extension SignUpErrorExtention on SignUpError {
  String? getString(BuildContext context) {
    switch (this) {
      case SignUpError.error:
        return context.l10n.serverError;
      case SignUpError.notFound:
        return context.l10n.notFound;
      case SignUpError.duplicate:
        return context.l10n.dublicate;
      case SignUpError.none:
      case SignUpError.initial:
        return null;
    }
  }
}

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required SignUpError failure,
    required bool? fieldsIsCorrect,
    required bool showPasswordField,
  }) = _SignUpState;
}
