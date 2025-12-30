import 'package:dartz/dartz.dart';

import 'package:veteranam/shared/shared_dart.dart';

// ignore: one_member_abstracts
abstract class IFaqRepository {
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions();
}
