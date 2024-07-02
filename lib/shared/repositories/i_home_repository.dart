import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class IHomeRepository {
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions();
  void addMockQuestions();
}
