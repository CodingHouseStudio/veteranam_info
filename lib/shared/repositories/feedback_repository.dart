import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IFeedbackRepository)
class FeedbackRepository implements IFeedbackRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback) async {
    try {
      await _firestoreService.addFeedback(feedback);
      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
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
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
