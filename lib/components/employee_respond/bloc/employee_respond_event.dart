part of 'employee_respond_bloc.dart';

@freezed
class EmployeeRespondEvent with _$EmployeeRespondEvent {
  const factory EmployeeRespondEvent.emailUpdated(String email) = _EmailUpdated;
  const factory EmployeeRespondEvent.phoneUpdated(int phone) = _PhoneUpdated;
  const factory EmployeeRespondEvent.save() = _Save;
  const factory EmployeeRespondEvent.noResumeChanged({required bool noResume}) =
      _NoResumeChanged;
}
