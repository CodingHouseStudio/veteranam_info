part of 'password_reset_bloc.dart';

@freezed
class PasswordResetEvent with _$PasswordResetEvent {
  const factory PasswordResetEvent.started(String? code) = _Started;

  const factory PasswordResetEvent.passwordUpdated(String password) =
      _PasswordUpdated;
  const factory PasswordResetEvent.confirmPasswordUpdated(
    String confirmPassword,
  ) = _ConfirmPasswordUpdated;

  const factory PasswordResetEvent.resetPassword(String? code) = _ResetPassword;
}
