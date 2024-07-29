import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.home} ${KGroupText.model} ', () {
    final fullJson = {
      QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
      QuestionModelJsonField.title: KTestText.questionModelItems.first.title,
      QuestionModelJsonField.subtitle:
          KTestText.questionModelItems.first.subtitle,
      QuestionModelJsonField.navigationLink:
          KTestText.questionModelItems.first.navigationLink,
    };
    final nullableJson = {
      QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
      QuestionModelJsonField.title: KTestText.questionModelItems.first.title,
      QuestionModelJsonField.subtitle:
          KTestText.questionModelItems.first.subtitle,
      QuestionModelJsonField.navigationLink: null,
    };
    final convertorJson = {
      QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
      QuestionModelJsonField.title: List.generate(
        KMinMaxSize.titleMobileMaxLength,
        (_) => KTestText.questionModelItems.first.title
            .split(KTestText.questionModelItems.first.title),
      ).join().substring(0, KMinMaxSize.titleMobileMaxLength),
      QuestionModelJsonField.subtitle: List.generate(
        KMinMaxSize.subtitleMaxLength,
        (_) => KTestText.questionModelItems.first.subtitle
            .split(KTestText.questionModelItems.first.subtitle),
      ).join().substring(0, KMinMaxSize.subtitleMaxLength),
      QuestionModelJsonField.navigationLink:
          KTestText.questionModelItems.first.navigationLink,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final questionModel = QuestionModel.fromJson(fullJson);

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

      test('${KGroupText.nullable} ', () {
        final questionModel = QuestionModel.fromJson(nullableJson);

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

      test('${KGroupText.failure} ', () {
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

      test('${KGroupText.convertor} ', () {
        final questionModel = QuestionModel.fromJson(convertorJson);

        expect(questionModel.id, KTestText.questionModelItems.first.id);
        expect(
          questionModel.title.length,
          KMinMaxSize.titleMobileMaxLength,
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
      test('${KGroupText.full} ', () {
        final questionModel = KTestText.questionModelItems.first.toJson();

        expect(questionModel, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final questionModelJson = KTestText.questionModelItems.first
            .copyWith(navigationLink: null)
            .toJson();

        expect(questionModelJson, nullableJson);
      });

      test('${KGroupText.convertor} ', () {
        final questionModelJson = QuestionModel(
          id: KTestText.questionModelItems.first.id,
          title: List.generate(
            KMinMaxSize.titleMobileMaxLength,
            (_) => KTestText.questionModelItems.first.title
                .split(KTestText.questionModelItems.first.title),
          ).join(),
          subtitle: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.questionModelItems.first.subtitle
                .split(KTestText.questionModelItems.first.subtitle),
          ).join(),
          navigationLink: KTestText.questionModelItems.first.navigationLink,
        ).toJson();

        expect(questionModelJson, convertorJson);
      });
    });
  });
}
