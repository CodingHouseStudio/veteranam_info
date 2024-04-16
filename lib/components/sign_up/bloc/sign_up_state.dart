part of 'sign_up_bloc.dart';

enum SignUpError {
  duplicate,
  error,
  initial,
  toomany,
  none,
}

extension AuthFailureToSignUpError on SomeFailure {
  SignUpError toSignUpError() {
    switch (this) {
      case SomeFailure.duplicate:
        return SignUpError.duplicate;
      case SomeFailure.tooManyRequests:
        return SignUpError.toomany;
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
    required SignUpError failure,
    required FieldEnum fieldsState,
    required bool showPassword,
  }) = _SignUpState;
}
