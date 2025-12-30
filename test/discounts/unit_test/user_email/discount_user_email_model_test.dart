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
  group('Email ${KGroupText.model} ', () {
    final fullJson = {
      EmailModelJsonField.id: KTestVariables.emailModel.id,
      EmailModelJsonField.date:
          KTestVariables.emailModel.date.toIso8601String(),
      EmailModelJsonField.email: KTestVariables.emailModel.email,
      EmailModelJsonField.userId: KTestVariables.emailModel.userId,
      EmailModelJsonField.isValid: KTestVariables.emailModel.isValid,
    };
    final nullableJson = {
      EmailModelJsonField.id: KTestVariables.emailModel.id,
      EmailModelJsonField.date:
          KTestVariables.emailModel.date.toIso8601String(),
      EmailModelJsonField.email: KTestVariables.emailModel.email,
      EmailModelJsonField.userId: KTestVariables.emailModel.userId,
      EmailModelJsonField.isValid: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final emailModel = EmailModel.fromJson(fullJson);

        expect(
          emailModel.id,
          KTestVariables.emailModel.id,
        );
        expect(
          emailModel.date,
          KTestVariables.emailModel.date,
        );
        expect(
          emailModel.email,
          KTestVariables.emailModel.email,
        );
        expect(
          emailModel.userId,
          KTestVariables.emailModel.userId,
        );
        expect(
          emailModel.isValid,
          KTestVariables.emailModel.isValid,
        );
      });

      test('${KGroupText.nullable} ', () {
        final emailModel = EmailModel.fromJson(nullableJson);

        expect(
          emailModel.id,
          KTestVariables.emailModel.id,
        );
        expect(
          emailModel.date,
          KTestVariables.emailModel.date,
        );
        expect(
          emailModel.email,
          KTestVariables.emailModel.email,
        );
        expect(
          emailModel.userId,
          KTestVariables.emailModel.userId,
        );
        expect(
          emailModel.isValid,
          false,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          EmailModelJsonField.date: KTestVariables.emailModel.date,
          EmailModelJsonField.email: KTestVariables.emailModel.email,
          EmailModelJsonField.userId: KTestVariables.emailModel.userId,
          EmailModelJsonField.isValid: KTestVariables.emailModel.isValid,
        };

        expect(
          () => EmailModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final emailModelJson = KTestVariables.emailModel.toJson();

        expect(emailModelJson, fullJson);
      });
    });
  });
}
