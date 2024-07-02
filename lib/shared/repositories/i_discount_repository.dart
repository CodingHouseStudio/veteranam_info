import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems();

  void addMockDiscountItems();

  Future<Either<SomeFailure, List<DiscountModel>>> getDiscountsById(
    String userId,
  );

  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  );
}
