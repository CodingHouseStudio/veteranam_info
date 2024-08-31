import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Link ${KGroupText.model} ', () {
    final fullJson = {
      LinkModelJsonField.id: KTestText.linkModel.id,
      LinkModelJsonField.date: KTestText.linkModel.date.toIso8601String(),
      LinkModelJsonField.link: KTestText.linkModel.link,
      LinkModelJsonField.userId: KTestText.linkModel.userId,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final linkModel = LinkModel.fromJson(fullJson);

        expect(
          linkModel.id,
          KTestText.linkModel.id,
        );
        expect(
          linkModel.date,
          KTestText.linkModel.date,
        );
        expect(
          linkModel.link,
          KTestText.linkModel.link,
        );
        expect(
          linkModel.userId,
          KTestText.linkModel.userId,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          LinkModelJsonField.date: KTestText.linkModel.date,
          LinkModelJsonField.link: KTestText.linkModel.link,
          LinkModelJsonField.userId: KTestText.linkModel.userId,
        };

        expect(
          () => LinkModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final linkModelJson = KTestText.linkModel.toJson();

        expect(linkModelJson, fullJson);
      });
    });
  });
}
