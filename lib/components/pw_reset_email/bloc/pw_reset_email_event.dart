part of 'pw_reset_email_bloc.dart';

@freezed
sealed class PwResetEmailEvent with _$PwResetEmailEvent {
  const factory PwResetEmailEvent.started(String? email) = _Started;

  const factory PwResetEmailEvent.emailUpdated(String email) = _EmailUpdated;

  const factory PwResetEmailEvent.sendResetCode() = _SendResetCode;

  const factory PwResetEmailEvent.resetStatus() = _ResetStatus;
}
