import 'package:dartz/dartz.dart';
import 'package:kozak/shared/shared.dart';

// ignore: one_member_abstracts
abstract class IFeedbackRepository {
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback);
}
