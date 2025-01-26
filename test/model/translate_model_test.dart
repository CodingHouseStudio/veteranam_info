import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('Transle ${KGroupText.model} ', () {
    final fullJson = {
      TranslateModelJsonField.uk: KTestVariables.translateModel.uk,
      TranslateModelJsonField.en: KTestVariables.translateModel.en,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final transtlateModel = TranslateModel.fromJson(fullJson);

        expect(
          transtlateModel.uk,
          KTestVariables.translateModel.uk,
        );
        expect(
          transtlateModel.en,
          KTestVariables.translateModel.en,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // uk is missing
          TranslateModelJsonField.en: KTestVariables.translateModel.en,
        };

        expect(
          () => TranslateModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final transtlateModelJson = KTestVariables.translateModel.toJson();

        expect(transtlateModelJson, fullJson);
      });
    });
  });
}
