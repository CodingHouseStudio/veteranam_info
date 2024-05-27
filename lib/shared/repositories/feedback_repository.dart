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
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
