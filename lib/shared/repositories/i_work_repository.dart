import 'package:kozak/shared/shared.dart';

abstract class IWorkRepository {
  Stream<List<WorkModel>> getWorks();
  void addMockWorks();
}
