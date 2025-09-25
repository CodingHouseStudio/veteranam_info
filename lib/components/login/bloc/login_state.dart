part of 'login_bloc.dart';

// extension AuthFailureToLoginFailure on SomeFailure {
//   LoginFailure _toLogInError() {
//     switch (this) {
//       case FailureSend():
//         return LoginFailure.send;
//       case FailureUserNotFound():
//         return LoginFailure.notFound;
//       case FailureNetwork():
//         return LoginFailure.network;
//       case FailurePasswordWrong():
//         return LoginFailure.passwordWrong;
//       default:
//         return LoginFailure.error;
//     }
//   }
// }

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    required EmailFieldModel email,
    required PasswordFieldModel password,
    required SomeFailure? failure,
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
  // loginLoading,
  success;

  bool get isPassword =>
      this == LoginEnum.showPassword ||
      this == LoginEnum.passwordInProgress ||
      this == LoginEnum.passwordInvalidData;
}
