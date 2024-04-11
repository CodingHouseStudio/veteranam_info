import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IFeedbackRepository)
class FeedbackRepository implements IFeedbackRepository {
  final List<FeedbackModel> _feedbackItems = [];

  @override
  Future<Either<SomeFailure, bool>> sendFeedback(FeedbackModel feedback) async {
    try {
      _feedbackItems.add(feedback);
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(seconds: 1));
      return const Right(true);
    } on Exception catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
