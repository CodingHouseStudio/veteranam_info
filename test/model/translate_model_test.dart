import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Transle ${KGroupText.model} ', () {
    final fullJson = {
      TranslateModelJsonField.uk: KTestText.translateModel.uk,
      TranslateModelJsonField.en: KTestText.translateModel.en,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final transtlateModel = TranslateModel.fromJson(fullJson);

        expect(
          transtlateModel.uk,
          KTestText.translateModel.uk,
        );
        expect(
          transtlateModel.en,
          KTestText.translateModel.en,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // uk is missing
          TranslateModelJsonField.en: KTestText.translateModel.en,
        };

        expect(
          () => TranslateModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final transtlateModelJson = KTestText.translateModel.toJson();

        expect(transtlateModelJson, fullJson);
      });
    });
  });
}
