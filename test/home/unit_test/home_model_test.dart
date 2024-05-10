import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.home} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.questionModelItems.elementAt(0).id,
        'title': KTestText.questionModelItems.elementAt(0).title,
        'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
        'navigationLink':
            KTestText.questionModelItems.elementAt(0).navigationLink,
      };

      final questionModel = QuestionModel.fromJson(json);

      expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
      expect(
        questionModel.title,
        KTestText.questionModelItems.elementAt(0).title,
      );
      expect(
        questionModel.subtitle,
        KTestText.questionModelItems.elementAt(0).subtitle,
      );
      expect(
        questionModel.navigationLink,
        KTestText.questionModelItems.elementAt(0).navigationLink,
      );
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.questionModelItems.elementAt(0).id,
        'title': KTestText.questionModelItems.elementAt(0).title,
        'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
      };

      final questionModel = QuestionModel.fromJson(json);

      expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
      expect(
        questionModel.title,
        KTestText.questionModelItems.elementAt(0).title,
      );
      expect(
        questionModel.subtitle,
        KTestText.questionModelItems.elementAt(0).subtitle,
      );
      expect(questionModel.navigationLink, null);
    });

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.questionModelItems.elementAt(0).id,
        // title is missing
        'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
        'navigationLink':
            KTestText.questionModelItems.elementAt(0).navigationLink,
      };

      expect(
        () => QuestionModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.questionModelItems.elementAt(0).id,
        'title': List.generate(
          100,
          (_) => KTestText.questionModelItems
              .elementAt(0)
              .title
              .split(KTestText.questionModelItems.elementAt(0).title),
        ).join(),
        'subtitle': List.generate(
          100,
          (_) => KTestText.questionModelItems
              .elementAt(0)
              .subtitle
              .split(KTestText.questionModelItems.elementAt(0).subtitle),
        ).join(),
        'navigationLink':
            KTestText.questionModelItems.elementAt(0).navigationLink,
      };

      final questionModel = QuestionModel.fromJson(json);

      expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
      expect(
        questionModel.title.length,
        KMinMaxSize.questionsTitleMaxLength,
      );
      expect(
        questionModel.subtitle.length,
        KMinMaxSize.questionsSubtitleMaxLength,
      );
      expect(questionModel.navigationLink, null);
    });
  });
}
