import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IWorkRepository {
  Stream<List<WorkModel>> getWorks();
  void addMockWorks();
  Future<Either<SomeFailure, bool>> sendRespond(EmployeeRespondModel respond);
}
