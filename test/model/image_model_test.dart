import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Image ${KGroupText.model} ', () {
    final fullJson = {
      ImageModelJsonField.downloadURL: KTestText.imageModel.downloadURL,
      ImageModelJsonField.lastModifiedTS: KTestText.imageModel.lastModifiedTS,
      ImageModelJsonField.name: KTestText.imageModel.name,
      ImageModelJsonField.ref: KTestText.imageModel.ref,
      ImageModelJsonField.type: KTestText.imageModel.type,
    };
    final nullableJson = {
      ImageModelJsonField.downloadURL: KTestText.imageModel.downloadURL,
      ImageModelJsonField.lastModifiedTS: null,
      ImageModelJsonField.name: null,
      ImageModelJsonField.ref: null,
      ImageModelJsonField.type: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final imageModel = ImageModel.fromJson(fullJson);

        expect(
          imageModel.downloadURL,
          KTestText.imageModel.downloadURL,
        );
        expect(
          imageModel.lastModifiedTS,
          KTestText.imageModel.lastModifiedTS,
        );
        expect(
          imageModel.name,
          KTestText.imageModel.name,
        );
        expect(
          imageModel.ref,
          KTestText.imageModel.ref,
        );
        expect(
          imageModel.type,
          KTestText.imageModel.type,
        );
      });

      test('${KGroupText.nullable} ', () {
        final imageModel = ImageModel.fromJson(nullableJson);

        expect(
          imageModel.downloadURL,
          KTestText.imageModel.downloadURL,
        );
        expect(
          imageModel.lastModifiedTS,
          null,
        );
        expect(
          imageModel.name,
          null,
        );
        expect(
          imageModel.ref,
          null,
        );
        expect(
          imageModel.type,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // downloadURL is missing
          ImageModelJsonField.lastModifiedTS:
              KTestText.imageModel.lastModifiedTS,
          ImageModelJsonField.name: KTestText.imageModel.name,
          ImageModelJsonField.ref: KTestText.imageModel.ref,
          ImageModelJsonField.type: KTestText.imageModel.type,
        };

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final imageModelJson = KTestText.imageModel.toJson();

        expect(imageModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final imageModelJson = const ImageModel(
          downloadURL: KTestText.image,
        ).toJson();

        expect(imageModelJson, nullableJson);
      });
    });
  });
}
