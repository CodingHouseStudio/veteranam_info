import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Resume ${KGroupText.model} ', () {
    final fullJson = {
      ResumeModelJsonField.downloadURL: KTestVariables.resumeModel.downloadURL,
      ResumeModelJsonField.lastModifiedTS:
          KTestVariables.resumeModel.lastModifiedTS,
      ResumeModelJsonField.name: KTestVariables.resumeModel.name,
      ResumeModelJsonField.ref: KTestVariables.resumeModel.ref,
      ResumeModelJsonField.type: KTestVariables.resumeModel.type,
    };
    final nullableJson = {
      ResumeModelJsonField.downloadURL: KTestVariables.resumeModel.downloadURL,
      ResumeModelJsonField.lastModifiedTS: null,
      ResumeModelJsonField.name: null,
      ResumeModelJsonField.ref: null,
      ResumeModelJsonField.type: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final resumeModel = ResumeModel.fromJson(fullJson);

        expect(
          resumeModel.downloadURL,
          KTestVariables.resumeModel.downloadURL,
        );
        expect(
          resumeModel.lastModifiedTS,
          KTestVariables.resumeModel.lastModifiedTS,
        );
        expect(
          resumeModel.name,
          KTestVariables.resumeModel.name,
        );
        expect(
          resumeModel.ref,
          KTestVariables.resumeModel.ref,
        );
        expect(
          resumeModel.type,
          KTestVariables.resumeModel.type,
        );
      });

      test('${KGroupText.nullable} ', () {
        final resumeModel = ResumeModel.fromJson(nullableJson);

        expect(
          resumeModel.downloadURL,
          KTestVariables.resumeModel.downloadURL,
        );
        expect(
          resumeModel.lastModifiedTS,
          null,
        );
        expect(
          resumeModel.name,
          null,
        );
        expect(
          resumeModel.ref,
          null,
        );
        expect(
          resumeModel.type,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // downloadURL is missing
          ResumeModelJsonField.lastModifiedTS:
              KTestVariables.resumeModel.lastModifiedTS,
          ResumeModelJsonField.name: KTestVariables.resumeModel.name,
          ResumeModelJsonField.ref: KTestVariables.resumeModel.ref,
          ResumeModelJsonField.type: KTestVariables.resumeModel.type,
        };

        expect(
          () => ResumeModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final resumeModelJson = KTestVariables.resumeModel.toJson();

        expect(resumeModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final resumeModelJson = const ResumeModel(
          downloadURL: KTestVariables.downloadURL,
        ).toJson();

        expect(resumeModelJson, nullableJson);
      });
    });
  });
}
