import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.workEmployee} ${KGroupText.model} ', () {
    final fullJson = {
      WorkModelJsonField.id: KTestVariables.workModelItems.first.id,
      WorkModelJsonField.title: KTestVariables.workModelItems.first.title,
      WorkModelJsonField.price: KTestVariables.workModelItems.first.price,
      WorkModelJsonField.employerContact:
          KTestVariables.workModelItems.first.employerContact,
      WorkModelJsonField.companyName:
          KTestVariables.workModelItems.first.companyName,
      WorkModelJsonField.description:
          KTestVariables.workModelItems.first.description,
      WorkModelJsonField.category: KTestVariables.workModelItems.first.category,
      WorkModelJsonField.city: KTestVariables.workModelItems.first.city,
      WorkModelJsonField.remote: KTestVariables.workModelItems.first.remote,
    };
    final nullableJson = {
      WorkModelJsonField.id: KTestVariables.workModelItems.first.id,
      WorkModelJsonField.title: KTestVariables.workModelItems.first.title,
      WorkModelJsonField.price: KTestVariables.workModelItems.first.price,
      WorkModelJsonField.employerContact:
          KTestVariables.workModelItems.first.employerContact,
      WorkModelJsonField.companyName:
          KTestVariables.workModelItems.first.companyName,
      WorkModelJsonField.description:
          KTestVariables.workModelItems.first.description,
      WorkModelJsonField.category: null,
      WorkModelJsonField.city: null,
      WorkModelJsonField.remote: KTestVariables.workModelItems.first.remote,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final workModel = WorkModel.fromJson(fullJson);

        expect(
          workModel.id,
          KTestVariables.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestVariables.workModelItems.first.title,
        );
        expect(
          workModel.category,
          KTestVariables.workModelItems.first.category,
        );
        expect(
          workModel.city,
          KTestVariables.workModelItems.first.city,
        );
        expect(
          workModel.companyName,
          KTestVariables.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestVariables.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestVariables.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestVariables.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          KTestVariables.workModelItems.first.remote,
        );
      });

      test('${KGroupText.nullable} ', () {
        final workModel = WorkModel.fromJson(nullableJson);

        expect(
          workModel.id,
          KTestVariables.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestVariables.workModelItems.first.title,
        );
        expect(
          workModel.category,
          null,
        );
        expect(
          workModel.city,
          null,
        );
        expect(
          workModel.companyName,
          KTestVariables.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestVariables.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestVariables.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestVariables.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          false,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          WorkModelJsonField.title: KTestVariables.workModelItems.first.title,
          WorkModelJsonField.price: KTestVariables.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestVariables.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestVariables.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestVariables.workModelItems.first.description,
        };

        expect(
          () => WorkModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final workModelJson = KTestVariables.workModelItems.first.toJson();

        expect(workModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final workModelJson = KTestVariables.workModelItems.first
            .copyWith(category: null, city: null)
            .toJson();

        expect(workModelJson, nullableJson);
      });
    });
  });
}
