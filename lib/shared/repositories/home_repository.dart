import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final List<QuestionModel> _questionModelItems = [];

  @override
  Future<Either<SomeFailure, List<QuestionModel>>> getQuestions() async {
    try {
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(seconds: 1));
      return Right(_questionModelItems);
    } on Exception catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  void addMockQuestions() {
    for (var i = 0; i < KMockText.questionTitle.length; i++) {
      _questionModelItems.add(
        QuestionModel(
          id: i.toString(),
          title: KMockText.questionTitle[i],
          subtitle: KMockText.questionSubtitle,
        ),
      );
    }
  }
}
