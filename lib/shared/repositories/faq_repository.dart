import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(as: IFaqRepository)
class FaqRepository implements IFaqRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions() async {
    try {
      final questionItems = await _firestoreService.getQuestions();
      return Right(questionItems);
    } on FirebaseException catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  void addMockQuestions() {
    for (var i = 0; i < KMockText.questionTitle.length; i++) {
      _firestoreService.addQuestion(
        QuestionModel(
          id: '${ExtendedDateTime.id}$i',
          title: KMockText.questionTitle[i],
          subtitle: KMockText.questionSubtitle,
        ),
      );
    }
  }
}