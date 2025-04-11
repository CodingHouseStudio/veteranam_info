part of 'employee_respond_bloc.dart';

@freezed
sealed class EmployeeRespondEvent with _$EmployeeRespondEvent {
  const factory EmployeeRespondEvent.emailUpdated(String email) = _EmailUpdated;
  const factory EmployeeRespondEvent.phoneUpdated(String phone) = _PhoneUpdated;
  const factory EmployeeRespondEvent.save() = _Save;
  const factory EmployeeRespondEvent.noResumeChanged() = _NoResumeChanged;
  const factory EmployeeRespondEvent.loadResumeClicked() = _LoadResumeClicked;
}
