part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;

  const factory ProfileEvent.nameUpdated(
    String name,
  ) = _NameUpdated;

  const factory ProfileEvent.surnameUpdated(
    String surname,
  ) = _SurnameUpdated;

  const factory ProfileEvent.imageUpdated() = _ImageUpdated;

  const factory ProfileEvent.nicknameUpdated(
    String nickname,
  ) = _NicknameUpdated;

  const factory ProfileEvent.save() = _Save;
}
