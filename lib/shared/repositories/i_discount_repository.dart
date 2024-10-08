import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems(
      //{List<String>? reportIdItems}
      );

  Future<Either<SomeFailure, DiscountModel>> getDiscount(String id);

  void addMockDiscountItems();

  Stream<List<DiscountModel>> getDiscountsByUserId(
    String userId,
  );

  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  );

  Future<Either<SomeFailure, bool>> sendLink(
    LinkModel discountLink,
  );

  Future<Either<SomeFailure, bool>> userCanSendLink(
    String userId,
  );

  Future<Either<SomeFailure, bool>> sendEmail(
    EmailModel userEmail,
  );

  Future<Either<SomeFailure, int>> userCanSendUserEmail(
    String userId,
  );

  Future<Either<SomeFailure, bool>> addDiscount(DiscountModel discount);

  Future<Either<SomeFailure, bool>> deactivateDiscount({
    required DiscountModel discountModel,
  });
}
