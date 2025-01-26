import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('Link ${KGroupText.model} ', () {
    final fullJson = {
      LinkModelJsonField.id: KTestVariables.linkModel.id,
      LinkModelJsonField.date: KTestVariables.linkModel.date.toIso8601String(),
      LinkModelJsonField.link: KTestVariables.linkModel.link,
      LinkModelJsonField.userId: KTestVariables.linkModel.userId,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final linkModel = LinkModel.fromJson(fullJson);

        expect(
          linkModel.id,
          KTestVariables.linkModel.id,
        );
        expect(
          linkModel.date,
          KTestVariables.linkModel.date,
        );
        expect(
          linkModel.link,
          KTestVariables.linkModel.link,
        );
        expect(
          linkModel.userId,
          KTestVariables.linkModel.userId,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          LinkModelJsonField.date: KTestVariables.linkModel.date,
          LinkModelJsonField.link: KTestVariables.linkModel.link,
          LinkModelJsonField.userId: KTestVariables.linkModel.userId,
        };

        expect(
          () => LinkModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final linkModelJson = KTestVariables.linkModel.toJson();

        expect(linkModelJson, fullJson);
      });
    });
  });
}
