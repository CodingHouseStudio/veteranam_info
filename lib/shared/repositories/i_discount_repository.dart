import 'package:kozak/shared/shared.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems();

  void addMockDiscountItems();
}
