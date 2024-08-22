import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IFaqRepository {
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions();
  void addMockQuestions();
}
