import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Email ${KGroupText.model} ', () {
    final fullJson = {
      EmailModelJsonField.id: KTestText.emailModel.id,
      EmailModelJsonField.date: KTestText.emailModel.date.toIso8601String(),
      EmailModelJsonField.email: KTestText.emailModel.email,
      EmailModelJsonField.userId: KTestText.emailModel.userId,
      EmailModelJsonField.isValid: KTestText.emailModel.isValid,
    };
    final nullableJson = {
      EmailModelJsonField.id: KTestText.emailModel.id,
      EmailModelJsonField.date: KTestText.emailModel.date.toIso8601String(),
      EmailModelJsonField.email: KTestText.emailModel.email,
      EmailModelJsonField.userId: KTestText.emailModel.userId,
      EmailModelJsonField.isValid: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final emailModel = EmailModel.fromJson(fullJson);

        expect(
          emailModel.id,
          KTestText.emailModel.id,
        );
        expect(
          emailModel.date,
          KTestText.emailModel.date,
        );
        expect(
          emailModel.email,
          KTestText.emailModel.email,
        );
        expect(
          emailModel.userId,
          KTestText.emailModel.userId,
        );
        expect(
          emailModel.isValid,
          KTestText.emailModel.isValid,
        );
      });

      test('${KGroupText.nullable} ', () {
        final emailModel = EmailModel.fromJson(nullableJson);

        expect(
          emailModel.id,
          KTestText.emailModel.id,
        );
        expect(
          emailModel.date,
          KTestText.emailModel.date,
        );
        expect(
          emailModel.email,
          KTestText.emailModel.email,
        );
        expect(
          emailModel.userId,
          KTestText.emailModel.userId,
        );
        expect(
          emailModel.isValid,
          false,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          EmailModelJsonField.date: KTestText.emailModel.date,
          EmailModelJsonField.email: KTestText.emailModel.email,
          EmailModelJsonField.userId: KTestText.emailModel.userId,
          EmailModelJsonField.isValid: KTestText.emailModel.isValid,
        };

        expect(
          () => EmailModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final emailModelJson = KTestText.emailModel.toJson();

        expect(emailModelJson, fullJson);
      });
    });
  });
}
