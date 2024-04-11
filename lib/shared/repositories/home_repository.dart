import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions() async {
    try {
      final questionItems = await _firestoreService.getQuestions();
      return Right(questionItems);
    } on Exception catch (e) {
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
          id: i.toString(),
          title: KMockText.questionTitle[i],
          subtitle: KMockText.questionSubtitle,
        ),
      );
    }
  }
}
