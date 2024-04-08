import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final List<QuestionModel> _questionModelItems = [];
  final _questionsController = StreamController<List<QuestionModel>>()..add([]);

  @override
  Stream<List<QuestionModel>> getQuestions() {
    return _questionsController.stream;
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
    _questionsController.add(_questionModelItems);
  }
}
