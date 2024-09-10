part of 'sign_up_bloc.dart';

enum SignUpError {
  duplicate,
  error,
  network,
  send,
}

extension AuthFailureToSignUpError on SomeFailure {
  SignUpError _toSignUpError() {
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
    required SignUpEnum formState,
  }) = _SignUpState;
}

enum SignUpEnum {
  initial,
  showPassword,
  inProgress,
  invalidData,
  success,
  passwordInProgress,
  passwordInvalidData,
}
