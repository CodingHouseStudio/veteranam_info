part of 'profile_bloc.dart';

enum ProfileFailure {
  error,
  network,
  send,
}

extension ProfileFailureExtension on SomeFailure {
  ProfileFailure _toProfileError() {
    switch (this) {
      case FailureSend():
        return ProfileFailure.send;
      case FailureNetwork():
        return ProfileFailure.network;
      default:
        return ProfileFailure.error;
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required NameFieldModel name,
    required SurnameFieldModel surname,
    required ImageFieldModel image,
    required NicknameFieldModel nickname,
    required ProfileFailure? failure,
    required ProfileEnum formState,
  }) = _ProfileState;
}

enum ProfileEnum {
  initial,
  inProgress,
  invalidData,
  success,
  succesesUnmodified,
  sendInProgress;
}
