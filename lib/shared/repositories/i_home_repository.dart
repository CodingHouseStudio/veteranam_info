import 'package:kozak/shared/shared.dart';

abstract class IHomeRepository {
  Stream<List<QuestionModel>> getQuestions();
  void addMockQuestions();
}
