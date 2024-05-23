part of 'employee_respond_bloc.dart';

enum EmployeeRespondFailure { none, error, initial }

extension EmployeeRespondFailureExtension on SomeFailure {
  EmployeeRespondFailure toEmployeeRespond() {
    return EmployeeRespondFailure.error;
  }
}

@freezed
class EmployeeRespondState with _$EmployeeRespondState {
  const factory EmployeeRespondState.initial() = _Initial;
}

enum EmployeeRespondEnum {
  initial,
  clear,
  sendingData,
  success,
  invalidData,
}
