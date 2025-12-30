import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/models/models.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.image} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestVariables.imageModel.downloadURL,
          'lastModifiedTS': KTestVariables.imageModel.lastModifiedTS,
          'name': KTestVariables.imageModel.name,
          'ref': KTestVariables.imageModel.ref,
          'type': KTestVariables.imageModel.type,
        };

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.downloadURL, KTestVariables.imageModel.downloadURL);
        expect(
          imageModel.lastModifiedTS,
          KTestVariables.imageModel.lastModifiedTS,
        );
        expect(imageModel.name, KTestVariables.imageModel.name);
        expect(imageModel.ref, KTestVariables.imageModel.ref);
        expect(imageModel.type, KTestVariables.imageModel.type);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestVariables.imageModel.downloadURL,
        };

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.downloadURL, KTestVariables.imageModel.downloadURL);
        expect(imageModel.lastModifiedTS, null);
        expect(imageModel.name, null);
        expect(imageModel.ref, null);
        expect(imageModel.type, null);
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // downloadURL is missing
          'lastModifiedTS': KTestVariables.imageModel.lastModifiedTS,
          'name': KTestVariables.imageModel.name,
          'ref': KTestVariables.imageModel.ref,
          'type': KTestVariables.imageModel.type,
        };

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestVariables.imageModel.downloadURL,
          'lastModifiedTS': KTestVariables.imageModel.lastModifiedTS,
          'name': KTestVariables.imageModel.name,
          'ref': KTestVariables.imageModel.ref,
          'type': KTestVariables.imageModel.type,
        };

        final imageModelJson = KTestVariables.imageModel.toJson();

        expect(imageModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestVariables.imageModel.downloadURL,
          'lastModifiedTS': null,
          'name': null,
          'ref': null,
          'type': null,
        };

        final imageModelJson =
            ImageModel(downloadURL: KTestVariables.imageModel.downloadURL)
                .toJson();

        expect(imageModelJson, json);
      });
    });
  });
}
