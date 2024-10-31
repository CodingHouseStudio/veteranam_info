part of 'pw_reset_email_bloc.dart';

extension AuthFailureToPwResetEmailFailure on SomeFailure {
  PwResetEmailFailure _toPwResetEmailError() {
    switch (this) {
      case FailureSend():
        return PwResetEmailFailure.send;
      case FailureNotFound():
        return PwResetEmailFailure.notFound;
      case FailureNetwork():
        return PwResetEmailFailure.network;
      default:
        return PwResetEmailFailure.error;
    }
  }
}

@freezed
class PwResetEmailState with _$PwResetEmailState {
  const factory PwResetEmailState({
    required EmailFieldModel email,
    required PwResetEmailEnum formState,
    required PwResetEmailFailure? failure,
  }) = _Initial;
}

enum PwResetEmailEnum {
  initial,
  inProgress,
  invalidData,
  sending,
  resending,
  success;

  bool get isSended =>
      this == PwResetEmailEnum.success || this == PwResetEmailEnum.resending;
  bool get isSending =>
      this == PwResetEmailEnum.sending || this == PwResetEmailEnum.resending;
}
