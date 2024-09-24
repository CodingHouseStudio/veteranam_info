part of 'profile_bloc.dart';

enum ProfileError {
  error,
  notFound,
  network,
  send,
}

extension AuthFailureToProfileError on SomeFailure {
  ProfileError _toProfileError() {
    switch (this) {
      case FailureSend():
        return ProfileError.send;
      case FailureNotFound():
        return ProfileError.notFound;
      case FailureNetwork():
        return ProfileError.network;
      default:
        return ProfileError.error;
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
    required ProfileError? failure,
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

  bool get showMessage =>
      this == ProfileEnum.success ||
      this == ProfileEnum.sendInProgress ||
      this == ProfileEnum.succesesUnmodified;
}
