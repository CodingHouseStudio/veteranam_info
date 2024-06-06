part of 'help_find_job_watcher_bloc.dart';

enum HelpFindJobError {
  none,
  error,
  notFound,
  initial,
}

extension AuthFailureToLeaveRequestError on SomeFailure {
  HelpFindJobError toLeaveRequestError() {
    switch (this) {
      case FailureNotFound():
        return HelpFindJobError.notFound;
      default:
        return HelpFindJobError.error;
    }
  }
}

extension LeaveRequestExtention on HelpFindJobError {
  String? getString(BuildContext context) {
    switch (this) {
      case HelpFindJobError.error:
        return context.l10n.serverError;
      case HelpFindJobError.notFound:
        return context.l10n.notFound;
      case HelpFindJobError.none:
      case HelpFindJobError.initial:
        return null;
    }
  }
}

@freezed
class HelpFindJobState with _$HelpFindJobState {
  const factory HelpFindJobState({
    required NameFieldModel name,
    required EmailFieldModel email,
    required PhoneNumberFieldModel phoneNumber,
    required String city,
    required bool isRemote,
    required String position,
    required String category,
    required HelpFindJobError failure,
    required bool? fieldsIsCorrect,
    required String message,
    File? resume,
  }) = _HelpFindJobState;
}
