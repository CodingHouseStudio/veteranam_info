import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IFeedbackRepository)
class FeedbackRepository implements IFeedbackRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();

  @override
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback) async {
    try {
      await _firestoreService.addFeedback(feedback);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> sendMobFeedback({
    required FeedbackModel feedback,
    required Uint8List image,
  }) async {
    try {
      final feedbackModel = await _addImage(
        feedback: feedback,
        image: image,
      );
      await _firestoreService.addMobFeedback(feedbackModel);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, bool>> checkUserNeedShowFeedback(
    String userId,
  ) async {
    try {
      final feedback = await _firestoreService.getUserFeedback(userId);
      final date = DateTime.now()
          .subtract(const Duration(days: KDimensions.daysBetweenFeedback));
      final lastFeedback =
          feedback.reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b);
      if (lastFeedback.timestamp.isAfter(date)) {
        return const Right(false);
      } else {
        return const Right(true);
      }
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  Future<FeedbackModel> _addImage({
    required Uint8List image,
    required FeedbackModel feedback,
  }) async {
    final downloadURL = await _storageService.saveUseUint8ListImage(
      image: image,
      id: feedback.id,
      collecltionName: FirebaseCollectionName.mobFeedback,
    );
    if (downloadURL.isNotEmpty) {
      return feedback.copyWith(
        image: ImageModel(
          downloadURL: downloadURL,
        ),
      );
    }

    return feedback;
  }
}
