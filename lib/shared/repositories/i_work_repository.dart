import 'package:veteranam/shared/shared.dart';

abstract class IWorkRepository {
  Stream<List<WorkModel>> getWorks();
  void addMockWorks();
}
