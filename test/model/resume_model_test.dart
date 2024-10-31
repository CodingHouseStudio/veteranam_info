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
      ResumeModelJsonField.downloadURL: KTestText.resumeModel.downloadURL,
      ResumeModelJsonField.lastModifiedTS: KTestText.resumeModel.lastModifiedTS,
      ResumeModelJsonField.name: KTestText.resumeModel.name,
      ResumeModelJsonField.ref: KTestText.resumeModel.ref,
      ResumeModelJsonField.type: KTestText.resumeModel.type,
    };
    final nullableJson = {
      ResumeModelJsonField.downloadURL: KTestText.resumeModel.downloadURL,
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
          KTestText.resumeModel.downloadURL,
        );
        expect(
          resumeModel.lastModifiedTS,
          KTestText.resumeModel.lastModifiedTS,
        );
        expect(
          resumeModel.name,
          KTestText.resumeModel.name,
        );
        expect(
          resumeModel.ref,
          KTestText.resumeModel.ref,
        );
        expect(
          resumeModel.type,
          KTestText.resumeModel.type,
        );
      });

      test('${KGroupText.nullable} ', () {
        final resumeModel = ResumeModel.fromJson(nullableJson);

        expect(
          resumeModel.downloadURL,
          KTestText.resumeModel.downloadURL,
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
              KTestText.resumeModel.lastModifiedTS,
          ResumeModelJsonField.name: KTestText.resumeModel.name,
          ResumeModelJsonField.ref: KTestText.resumeModel.ref,
          ResumeModelJsonField.type: KTestText.resumeModel.type,
        };

        expect(
          () => ResumeModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final resumeModelJson = KTestText.resumeModel.toJson();

        expect(resumeModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final resumeModelJson = const ResumeModel(
          downloadURL: KTestText.downloadURL,
        ).toJson();

        expect(resumeModelJson, nullableJson);
      });
    });
  });
}
