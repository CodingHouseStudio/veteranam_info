import 'package:kozak/shared/models/failure_model/some_failure_model.dart';

enum EmployeeRespondFailure {
  error,
}

extension WorkFailureExtension on SomeFailure {
  EmployeeRespondFailure toWork() {
    return EmployeeRespondFailure.error;
  }
}
