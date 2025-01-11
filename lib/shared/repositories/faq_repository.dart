// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IFaqRepository, env: [Config.user, Config.mobile])
class FaqRepository implements IFaqRepository {
  FaqRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;

  @override
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions() async {
    try {
      final questionItems = await _firestoreService.getQuestions();
      return Right(questionItems);
    } catch (e, stack) {
      return Left(
        SomeFailure.value(
          error: e,
          stack: stack,
          tag: 'FAQ(getQuestions)',
          tagKey: ErrorText.repositoryKey,
        ),
      );
    }
  }
}
