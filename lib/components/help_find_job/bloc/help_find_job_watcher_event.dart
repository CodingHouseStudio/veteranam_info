part of 'help_find_job_watcher_bloc.dart';

@freezed
class HelpFindJobEvent with _$HelpFindJobEvent {
  const factory HelpFindJobEvent.emailUpdated(String email) = _EmailUpdated;

  const factory HelpFindJobEvent.phoneNumberUpdated(String number) =
      _PhoneNumberUpdated;

  const factory HelpFindJobEvent.cityChanged(String city) = _CityChanged;

  const factory HelpFindJobEvent.remoteWorkToggled({required bool isRemote}) =
      _RemoteWorkToggled;

  const factory HelpFindJobEvent.positionChanged(String position) =
      _PositionChanged;

  const factory HelpFindJobEvent.categoryChanged(String category) =
      _CategoryChanged;

  const factory HelpFindJobEvent.resumeUploaded(File file) = _ResumeUploaded;

  const factory HelpFindJobEvent.leaveRequestSubmitted() =
      _LeaveRequestSubmitted;

  const factory HelpFindJobEvent.messageUpdated(String message) =
      _MessageUpdated;
}
