import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.home} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title:
              KTestText.questionModelItems.first.title,
          QuestionModelJsonField.subtitle:
              KTestText.questionModelItems.first.subtitle,
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.first.id);
        expect(
          questionModel.title,
          KTestText.questionModelItems.first.title,
        );
        expect(
          questionModel.subtitle,
          KTestText.questionModelItems.first.subtitle,
        );
        expect(
          questionModel.navigationLink,
          KTestText.questionModelItems.first.navigationLink,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title:
              KTestText.questionModelItems.first.title,
          QuestionModelJsonField.subtitle:
              KTestText.questionModelItems.first.subtitle,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.first.id);
        expect(
          questionModel.title,
          KTestText.questionModelItems.first.title,
        );
        expect(
          questionModel.subtitle,
          KTestText.questionModelItems.first.subtitle,
        );
        expect(questionModel.navigationLink, null);
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          // title is missing
          QuestionModelJsonField.subtitle:
              KTestText.questionModelItems.first.subtitle,
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };

        expect(
          () => QuestionModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title: List.generate(
            100,
            (_) => KTestText.questionModelItems.first.title
                .split(KTestText.questionModelItems.first.title),
          ).join(),
          QuestionModelJsonField.subtitle: List.generate(
            100,
            (_) => KTestText.questionModelItems.first.subtitle
                .split(KTestText.questionModelItems.first.subtitle),
          ).join(),
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.first.id);
        expect(
          questionModel.title.length,
          KMinMaxSize.questionsTitleMaxLength,
        );
        expect(
          questionModel.subtitle.length,
          KMinMaxSize.subtitleMaxLength,
        );
        expect(
          questionModel.navigationLink,
          KTestText.questionModelItems.first.navigationLink,
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title:
              KTestText.questionModelItems.first.title,
          QuestionModelJsonField.subtitle:
              KTestText.questionModelItems.first.subtitle,
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };

        final questionModel = KTestText.questionModelItems.first.toJson();

        expect(questionModel, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title:
              KTestText.questionModelItems.first.title,
          QuestionModelJsonField.subtitle:
              KTestText.questionModelItems.first.subtitle,
          QuestionModelJsonField.navigationLink: null,
        };

        final questionModelJson = KTestText.questionModelItems.first
            .copyWith(navigationLink: null)
            .toJson();

        expect(questionModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final questionModel = QuestionModel(
          id: KTestText.questionModelItems.first.id,
          title: List.generate(
            KMinMaxSize.questionsTitleMaxLength,
            (_) => KTestText.questionModelItems.first.title
                .split(KTestText.questionModelItems.first.title),
          ).join().substring(0, KMinMaxSize.questionsTitleMaxLength),
          subtitle: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.questionModelItems.first.subtitle
                .split(KTestText.questionModelItems.first.subtitle),
          ).join().substring(0, KMinMaxSize.subtitleMaxLength),
          navigationLink: KTestText.questionModelItems.first.navigationLink,
        );
        final json = {
          QuestionModelJsonField.id: questionModel.id,
          QuestionModelJsonField.title: questionModel.title,
          QuestionModelJsonField.subtitle: questionModel.subtitle,
          QuestionModelJsonField.navigationLink: questionModel.navigationLink,
        };

        final questionModelJson = questionModel
            .copyWith(
              title: List.generate(
                KMinMaxSize.questionsTitleMaxLength,
                (_) => KTestText.questionModelItems.first.title
                    .split(KTestText.questionModelItems.first.title),
              ).join(),
              subtitle: List.generate(
                KMinMaxSize.subtitleMaxLength,
                (_) => KTestText.questionModelItems.first.subtitle
                    .split(KTestText.questionModelItems.first.subtitle),
              ).join(),
            )
            .toJson();

        expect(questionModelJson, json);
      });
    });
  });
}
