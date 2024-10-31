import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared_dart.dart';

abstract class IFaqRepository {
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions();
  void addMockQuestions();
}
