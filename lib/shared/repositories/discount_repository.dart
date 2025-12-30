import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;

@Singleton(
  as: IDiscountRepository,
  // signalsReady: true,
)
class DiscountRepository implements IDiscountRepository {
  DiscountRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;
  @override
  Stream<List<DiscountModel>> getDiscountItems({
    required bool showOnlyBusinessDiscounts,
  }) =>
      _firestoreService.getDiscounts(
        showOnlyBusinessDiscounts: showOnlyBusinessDiscounts,
      );

  @override
  Future<void> addMockDiscountItems() async {
    // final tagsSnapshot = await _firestoreService.getTags().first;

    // final tagMap = {
    //   for (final tag in tagsSnapshot) tag.id: tag,
    // };

    for (var i = 0; i < 5; i++) {
      await _firestoreService.addDiscount(
        KMockText.discountModel.copyWith(
          id: '${ExtendedDateTime.id}$i',
          userId: '${ExtendedDateTime.id}$i',
          dateVerified: ExtendedDateTime.current,
        ),
      );
    }
  }

  @override
  Stream<List<DiscountModel>> getDiscountsByCompanyId(
    String companyId,
  ) =>
      _firestoreService.getDiscounts(
        userId: companyId,
        showOnlyBusinessDiscounts: false,
      );

  @override
  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  ) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.deleteDiscountById(discountId);
        return const Right(true);
      },
      methodName: 'Discount(deleteDiscountsById)',
      className: ErrorText.repositoryKey,
      data: 'Discount Id: $discountId',
    );
  }

  @override
  Future<Either<SomeFailure, DiscountModel>> getDiscount({
    required String id,
    required bool showOnlyBusinessDiscounts,
  }) async {
    return eitherFutureHelper(
      () async {
        final discountModel = await _firestoreService.getDiscount(
          id: id,
          showOnlyBusinessDiscounts: showOnlyBusinessDiscounts,
        );
        return Right(discountModel);
      },
      methodName: 'Discount(getDiscount)',
      className: ErrorText.repositoryKey,
      data: 'Discount Id: $id',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> sendLink(
    LinkModel discountLink,
  ) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.sendLink(discountLink);
        return const Right(true);
      },
      methodName: 'Discount(sendLink)',
      className: ErrorText.repositoryKey,
      data: 'Discount Link: $discountLink',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> userCanSendLink(
    String userId,
  ) async {
    return eitherFutureHelper(
      () async {
        final userLink = await _firestoreService.getUserDiscountsLink(userId);
        final oneDayAgo =
            ExtendedDateTime.current.subtract(const Duration(days: 1));
        final oneDayUserLink = userLink
            .where(
              (element) => element.date.isAfter(oneDayAgo),
            )
            .toList();
        return Right(oneDayUserLink.length < KDimensions.maxLinkPerDay);
      },
      methodName: 'Discount(userCanSendLink)',
      className: ErrorText.repositoryKey,
      user: User(id: userId),
      data: 'User ID: $userId',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> sendEmail(
    EmailModel userEmail,
  ) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.sendEmail(userEmail);
        return const Right(true);
      },
      methodName: 'Discount(sendEmail)',
      className: ErrorText.repositoryKey,
      data: 'User Email: $userEmail',
    );
  }

  @override
  Future<Either<SomeFailure, int>> userCanSendUserEmail(
    String userId,
  ) async {
    return eitherFutureHelper(
      () async {
        final userEmails =
            await _firestoreService.getUserDiscountsEmail(userId);
        // if (userEmails.isEmpty) {
        //   return const Right(true);
        // }
        final oneDaysAgo =
            ExtendedDateTime.current.subtract(const Duration(days: 1));

        final userSentEmail =
            userEmails.any((record) => record.date.isAfter(oneDaysAgo));
        if (userSentEmail || userEmails.any((element) => element.isValid)) {
          return const Right(-1);
        }

        return Right(userEmails.length);
      },
      methodName: 'Discount(userCanSendUserEmail)',
      className: ErrorText.repositoryKey,
      user: User(id: userId),
      data: 'User ID: $userId',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> addDiscount(DiscountModel discount) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.addDiscount(discount.getForAdd);

        return const Right(true);
      },
      methodName: 'Discount(addDiscount)',
      className: ErrorText.repositoryKey,
      data: 'Discount: $discount',
    );
  }

  @override
  Future<Either<SomeFailure, bool>> deactivateDiscount({
    required DiscountModel discountModel,
  }) async {
    return eitherFutureHelper(
      () async {
        await _firestoreService.updateDiscountModel(
          discountModel.copyWith(
            status: discountModel.status == DiscountState.deactivated
                ? DiscountState.published
                : DiscountState.deactivated,
          ),
        );
        return const Right(true);
      },
      methodName: 'Discount(deactivateDiscount)',
      className: ErrorText.repositoryKey,
      data: 'Discount: $discountModel',
    );
  }

  @override
  Future<Either<SomeFailure, DiscountModel>> getCompanyDiscount({
    required String id,
    required String companyId,
  }) async {
    return eitherFutureHelper(
      () async {
        final discountModel = await _firestoreService.getDiscount(
          id: id,
          companyId: companyId,
          showOnlyBusinessDiscounts: false,
        );
        return Right(discountModel);
      },
      methodName: 'Discount(getCompanyDiscount)',
      className: ErrorText.repositoryKey,
      data: 'Discount ID: $id, Company ID: $companyId',
      user: User(id: companyId),
    );
  }

  @override
  Future<bool> companyHasDiscount(
    String companyId,
  ) async {
    return valueFutureErrorHelper(
      () async => _firestoreService.companyHasDiscounts(
        companyId,
      ),
      failureValue: true,
      methodName: 'companyHasDiscount',
      className: 'Discount ${ErrorText.repositoryKey}',
      data: 'Company ID: $companyId',
      user: User(id: companyId),
    );
  }
}
