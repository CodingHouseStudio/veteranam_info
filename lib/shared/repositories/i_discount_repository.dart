import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems();
  Future<Either<SomeFailure, DiscountModel>> getDiscount(String id);

  void addMockDiscountItems();

  Future<Either<SomeFailure, List<DiscountModel>>> getDiscountsByUserId(
    String userId,
  );

  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  );

  Future<Either<SomeFailure, bool>> sendLink(
    String link,
  );
}
