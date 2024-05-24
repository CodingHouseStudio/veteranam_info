import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

abstract class IFeedbackRepository {
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback);
  Future<Either<SomeFailure, bool>> checkUserNeedShowFeedback(String userId);
}
