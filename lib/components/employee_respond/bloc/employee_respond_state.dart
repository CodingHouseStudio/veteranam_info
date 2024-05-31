part of 'employee_respond_bloc.dart';

enum EmployeeRespondFailure { none, error, initial }

extension EmployeeRespondFailureExtension on SomeFailure {
  EmployeeRespondFailure toEmployeeRespond() {
    return EmployeeRespondFailure.error;
  }
}

@freezed
class EmployeeRespondState with _$EmployeeRespondState {
  const factory EmployeeRespondState({
    required EmailFieldModel email,
    required PhoneNumberFieldModel phoneNumber,
    required ResumeFieldModel resume,
    required bool noResume,
    required EmployeeRespondEnum formState,
    required EmployeeRespondFailure failure,
  }) = _EmployeeRespondState;
}

enum EmployeeRespondEnum {
  initial,
  clear,
  sendingData,
  success,
  invalidData,
}
