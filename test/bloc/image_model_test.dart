import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.image} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestText.imageModel.downloadURL,
          'lastModifiedTS': KTestText.imageModel.lastModifiedTS,
          'name': KTestText.imageModel.name,
          'ref': KTestText.imageModel.ref,
          'type': KTestText.imageModel.type,
        };

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.downloadURL, KTestText.imageModel.downloadURL);
        expect(imageModel.lastModifiedTS, KTestText.imageModel.lastModifiedTS);
        expect(imageModel.name, KTestText.imageModel.name);
        expect(imageModel.ref, KTestText.imageModel.ref);
        expect(imageModel.type, KTestText.imageModel.type);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestText.imageModel.downloadURL,
        };

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.downloadURL, KTestText.imageModel.downloadURL);
        expect(imageModel.lastModifiedTS, null);
        expect(imageModel.name, null);
        expect(imageModel.ref, null);
        expect(imageModel.type, null);
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // downloadURL is missing
          'lastModifiedTS': KTestText.imageModel.lastModifiedTS,
          'name': KTestText.imageModel.name,
          'ref': KTestText.imageModel.ref,
          'type': KTestText.imageModel.type,
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
          'downloadURL': KTestText.imageModel.downloadURL,
          'lastModifiedTS': KTestText.imageModel.lastModifiedTS,
          'name': KTestText.imageModel.name,
          'ref': KTestText.imageModel.ref,
          'type': KTestText.imageModel.type,
        };

        final imageModelJson = KTestText.imageModel.toJson();

        expect(imageModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'downloadURL': KTestText.imageModel.downloadURL,
          'lastModifiedTS': null,
          'name': null,
          'ref': null,
          'type': null,
        };

        final imageModelJson =
            ImageModel(downloadURL: KTestText.imageModel.downloadURL).toJson();

        expect(imageModelJson, json);
      });
    });
  });
}
