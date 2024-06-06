import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems();

  void addMockDiscountItems();

  Future<Either<SomeFailure, List<DiscountModel>>> getDiscountsById(
    String userId,
  );
}
