part of 'password_reset_bloc.dart';

// extension AuthFailureToPasswordResetFailure on SomeFailure {
//   PasswordResetFailure _toPasswordResetError() {
//     switch (this) {
//       case FailureSend():
//         return PasswordResetFailure.send;
//       case FailureNetwork():
//         return PasswordResetFailure.network;
//       default:
//         return PasswordResetFailure.error;
//     }
//   }
// }

@freezed
class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState({
    required PasswordFieldModel password,
    required PasswordFieldModel confirmPassword,
    required PasswordResetEnum formState,
    required SomeFailure? failure,
  }) = _Initial;
}

enum PasswordResetEnum {
  initial,
  inProgress,
  invalidData,
  sending,
  success,
  passwordMismatch;

  bool get isLoading =>
      this == PasswordResetEnum.success || this == PasswordResetEnum.sending;
}
