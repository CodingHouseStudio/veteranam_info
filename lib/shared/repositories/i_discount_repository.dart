import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IDiscountRepository {
  Stream<List<DiscountModel>> getDiscountItems({
    required bool showOnlyBusinessDiscounts,
  });

  Future<Either<SomeFailure, DiscountModel>> getDiscount({
    required String id,
    required bool showOnlyBusinessDiscounts,
  });

  Future<Either<SomeFailure, DiscountModel>> getCompanyDiscount({
    required String id,
    required String companyId,
  });

  Future<bool> companyHasDiscount(
    String companyId,
  );

  void addMockDiscountItems();

  Stream<List<DiscountModel>> getDiscountsByCompanyId(
    String companyId,
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
