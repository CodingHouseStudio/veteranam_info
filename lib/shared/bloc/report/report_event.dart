part of 'report_bloc.dart';

@freezed
class ReportEvent with _$ReportEvent {
  const factory ReportEvent.started(
    String cardId,
  ) = _Started;
  const factory ReportEvent.reasonComplaintUpdated(
    ReasonComplaint reasonComplaint,
  ) = _ReasonComplaintUpdated;
  // const factory ReportEvent.emailUpdated(String email) = _EmailUpdated;
  const factory ReportEvent.messageUpdated(String message) = _MessageUpdated;
  const factory ReportEvent.send(CardEnum card) = _Send;
}
