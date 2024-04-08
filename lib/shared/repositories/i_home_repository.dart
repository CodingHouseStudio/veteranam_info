import 'package:kozak/shared/shared.dart';

abstract class IHomeRepository {
  List<QuestionModel> getQuestions();
  void addMockQuestions();
}
