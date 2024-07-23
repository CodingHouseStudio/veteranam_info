import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IDiscountRepository)
class DiscountRepository implements IDiscountRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Stream<List<DiscountModel>> getDiscountItems() =>
      _firestoreService.getDiscounts();

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
  Future<Either<SomeFailure, List<DiscountModel>>> getDiscountsByUserId(
    String userId,
  ) async {
    try {
      final userDiscountsItems =
          await _firestoreService.getDiscountsByUserId(userId);

      return Right(userDiscountsItems);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> deleteDiscountsById(
    String discountId,
  ) async {
    try {
      await _firestoreService.deleteDiscountById(discountId);
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, DiscountModel>> getDiscount(
    String id,
  ) async {
    try {
      final discountModel = await _firestoreService.getDiscount(id);
      return Right(discountModel);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> sendLink(
    LinkModel discountLink,
  ) async {
    try {
      await _firestoreService.sendDiscountLink(discountLink);
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  Future<Either<SomeFailure, bool>> userCanSendLink(
    String userId,
  ) async {
    try {
      final userLink = await _firestoreService.getUserDiscountLink(userId);
      final oneDayAgo =
          ExtendedDateTime.current.subtract(const Duration(days: 1));
      final oneDayUserLink = userLink
          .where(
            (element) => element.date.isAfter(oneDayAgo),
          )
          .toList();
      return Right(oneDayUserLink.length < KDimensions.maxLinkPerDay);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
