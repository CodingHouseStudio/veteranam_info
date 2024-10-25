import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IWorkRepository {
  Stream<List<WorkModel>> getWorks();
  void addMockWorks();
  Future<Either<SomeFailure, bool>> sendRespond({
    required EmployeeRespondModel respond,
    required FilePickerItem? file,
  });
}
