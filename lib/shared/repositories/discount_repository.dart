import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  as: IDiscountRepository,
  // signalsReady: true,
)
class DiscountRepository implements IDiscountRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Stream<List<DiscountModel>> getDiscountItems(
          //{List<String>? reportIdItems}
          ) =>
      _firestoreService.getDiscounts(
          //reportIdItems
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
      _firestoreService.getDiscounts(userId: companyId);

  @override
  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  ) async {
    try {
      await _firestoreService.deleteDiscountById(discountId);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, DiscountModel>> getDiscount(
    String id,
  ) async {
    try {
      final discountModel = await _firestoreService.getDiscount(id: id);
      return Right(discountModel);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> sendLink(
    LinkModel discountLink,
  ) async {
    try {
      await _firestoreService.sendLink(discountLink);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> userCanSendLink(
    String userId,
  ) async {
    try {
      final userLink = await _firestoreService.getUserDiscountsLink(userId);
      final oneDayAgo =
          ExtendedDateTime.current.subtract(const Duration(days: 1));
      final oneDayUserLink = userLink
          .where(
            (element) => element.date.isAfter(oneDayAgo),
          )
          .toList();
      return Right(oneDayUserLink.length < KDimensions.maxLinkPerDay);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> sendEmail(
    EmailModel userEmail,
  ) async {
    try {
      await _firestoreService.sendEmail(userEmail);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, int>> userCanSendUserEmail(
    String userId,
  ) async {
    try {
      final userEmails = await _firestoreService.getUserDiscountsEmail(userId);
      // if (userEmails.isEmpty) {
      //   return const Right(true);
      // }
      final oneDaysAgo =
          ExtendedDateTime.current.subtract(const Duration(days: 1));

      final userSentEmail =
          userEmails.any((record) => record.date.isAfter(oneDaysAgo));
      if (userEmails.any((element) => element.isValid) || userSentEmail) {
        return const Right(-1);
      }

      return Right(userEmails.length);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> addDiscount(DiscountModel discount) async {
    try {
      await _firestoreService.addDiscount(discount);

      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> deactivateDiscount({
    required DiscountModel discountModel,
  }) async {
    try {
      await _firestoreService.updateDiscountModel(
        discountModel.copyWith(
          status: discountModel.status == DiscountState.deactivated
              ? DiscountState.published
              : DiscountState.deactivated,
        ),
      );
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, DiscountModel>> getCompanyDiscount({
    required String id,
    required String companyId,
  }) async {
    try {
      final discountModel = await _firestoreService.getDiscount(
        id: id,
        companyId: companyId,
      );
      return Right(discountModel);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<bool> companyHasDiscount(
    String companyId,
  ) async {
    try {
      return await _firestoreService.companyHasDiscounts(
        companyId,
      );
    } catch (e, stack) {
      SomeFailure.serverError(error: e, stack: stack);
      return true;
    }
  }
}
