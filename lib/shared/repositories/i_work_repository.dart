import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IWorkRepository {
  Future<Either<SomeFailure, List<WorkModel>>> getWorks();
  void addMockWorks();
}
