part of 'report_bloc.dart';

@freezed
sealed class ReportEvent with _$ReportEvent {
  // const factory ReportEvent.started(

  // ) = _Started;
  const factory ReportEvent.reasonComplaintUpdated(
    ReasonComplaint reasonComplaint,
  ) = _ReasonComplaintUpdated;
  const factory ReportEvent.emailUpdated(String email) = _EmailUpdated;
  const factory ReportEvent.messageUpdated(String message) = _MessageUpdated;
  const factory ReportEvent.send() = _Send;
  const factory ReportEvent.cancel() = _Cancel;
}
