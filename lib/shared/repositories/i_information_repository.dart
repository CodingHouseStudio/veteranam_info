import 'package:kozak/shared/shared.dart';

abstract class IInformationRepository {
  Stream<List<InformationModel>> getInformationItems();
  void addMockInformationItems();
}
