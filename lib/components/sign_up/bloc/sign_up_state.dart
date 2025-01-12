part of 'sign_up_bloc.dart';

// extension AuthFailureToSignUpError on SomeFailure {
//   SignUpError _toSignUpError() {
//     switch (this) {
//       case FailureUserDuplicate():
//         return SignUpError.duplicate;
//       case FailureSend():
//         return SignUpError.send;
//       case FailureNetwork():
//         return SignUpError.network;
//       case FailureEmailInvalidFormat():
//         return SignUpError.emailWrongFormat;
//       default:
//         return SignUpError.error;
//     }
//   }
// }

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required SomeFailure? failure,
    required SignUpEnum formState,
  }) = _SignUpState;
}

enum SignUpEnum {
  initial,
  showPassword,
  inProgress,
  invalidData,
  success,
  // singUpLoading,
  passwordInProgress,
  passwordInvalidData,
}
