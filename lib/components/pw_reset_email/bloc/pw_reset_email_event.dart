part of 'pw_reset_email_bloc.dart';

@freezed
class PwResetEmailEvent with _$PwResetEmailEvent {
  const factory PwResetEmailEvent.emailUpdated(String email) = _EmailUpdated;

  const factory PwResetEmailEvent.sendResetCode() = _SendResetCode;
}
