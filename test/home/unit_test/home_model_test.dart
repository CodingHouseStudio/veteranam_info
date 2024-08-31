import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
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
        final convertorJson = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title: List.generate(
            KMinMaxSize.titleMaxLength,
            (_) => KTestText.questionModelItems.first.title
                .split(KTestText.questionModelItems.first.title),
          ).join(),
          QuestionModelJsonField.subtitle: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.questionModelItems.first.subtitle
                .split(KTestText.questionModelItems.first.subtitle),
          ).join(),
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };

        final questionModel = QuestionModel.fromJson(convertorJson);

        expect(questionModel.id, KTestText.questionModelItems.first.id);
        expect(
          questionModel.title.length,
          KMinMaxSize.titleMaxLength,
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
        final convertorJson = {
          QuestionModelJsonField.id: KTestText.questionModelItems.first.id,
          QuestionModelJsonField.title: List.generate(
            KMinMaxSize.titleMaxLength,
            (_) => KTestText.questionModelItems.first.title
                .split(KTestText.questionModelItems.first.title),
          ).join().substring(0, KMinMaxSize.titleMaxLength),
          QuestionModelJsonField.subtitle: List.generate(
            KMinMaxSize.subtitleMaxLength,
            (_) => KTestText.questionModelItems.first.subtitle
                .split(KTestText.questionModelItems.first.subtitle),
          ).join().substring(0, KMinMaxSize.subtitleMaxLength),
          QuestionModelJsonField.navigationLink:
              KTestText.questionModelItems.first.navigationLink,
        };
        final questionModelJson = QuestionModel(
          id: KTestText.questionModelItems.first.id,
          title: List.generate(
            KMinMaxSize.titleMaxLength,
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
