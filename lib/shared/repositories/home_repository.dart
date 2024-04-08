import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final List<QuestionModel> _questionModelItems = [];

  @override
  List<QuestionModel> getQuestions() {
    return _questionModelItems;
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
