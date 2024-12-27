import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Image ${KGroupText.model} ', () {
    final fullJson = {
      ImageModelJsonField.downloadURL: KTestVariables.imageModel.downloadURL,
      ImageModelJsonField.lastModifiedTS:
          KTestVariables.imageModel.lastModifiedTS,
      ImageModelJsonField.name: KTestVariables.imageModel.name,
      ImageModelJsonField.ref: KTestVariables.imageModel.ref,
      ImageModelJsonField.type: KTestVariables.imageModel.type,
    };
    final nullableJson = {
      ImageModelJsonField.downloadURL: KTestVariables.imageModel.downloadURL,
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
          KTestVariables.imageModel.downloadURL,
        );
        expect(
          imageModel.lastModifiedTS,
          KTestVariables.imageModel.lastModifiedTS,
        );
        expect(
          imageModel.name,
          KTestVariables.imageModel.name,
        );
        expect(
          imageModel.ref,
          KTestVariables.imageModel.ref,
        );
        expect(
          imageModel.type,
          KTestVariables.imageModel.type,
        );
      });

      test('${KGroupText.nullable} ', () {
        final imageModel = ImageModel.fromJson(nullableJson);

        expect(
          imageModel.downloadURL,
          KTestVariables.imageModel.downloadURL,
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
              KTestVariables.imageModel.lastModifiedTS,
          ImageModelJsonField.name: KTestVariables.imageModel.name,
          ImageModelJsonField.ref: KTestVariables.imageModel.ref,
          ImageModelJsonField.type: KTestVariables.imageModel.type,
        };

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final imageModelJson = KTestVariables.imageModel.toJson();

        expect(imageModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final imageModelJson = const ImageModel(
          downloadURL: KTestVariables.image,
        ).toJson();

        expect(imageModelJson, nullableJson);
      });
    });
  });
}
