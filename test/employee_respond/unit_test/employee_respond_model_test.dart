import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ${KGroupText.model} ', () {
    final fullJson = {
      EmployeeRespondModelJsonField.id:
          KTestVariables.employeeRespondModelModel.id,
      EmployeeRespondModelJsonField.email:
          KTestVariables.employeeRespondModelModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestVariables.employeeRespondModelModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestVariables.employeeRespondModelModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: [
        KTestVariables.employeeRespondModelModel.resume!.toJson(),
      ],
    };
    final nullableJson = {
      EmployeeRespondModelJsonField.id:
          KTestVariables.employeeRespondModelModel.id,
      EmployeeRespondModelJsonField.email:
          KTestVariables.employeeRespondModelModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestVariables.employeeRespondModelModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestVariables.employeeRespondModelModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final employeeRespondModel = EmployeeRespondModel.fromJson(fullJson);

        expect(
          employeeRespondModel.id,
          KTestVariables.employeeRespondModelModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestVariables.employeeRespondModelModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestVariables.employeeRespondModelModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestVariables.employeeRespondModelModel.noResume,
        );
        expect(
          employeeRespondModel.resume,
          KTestVariables.employeeRespondModelModel.resume,
        );
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModel =
            EmployeeRespondModel.fromJson(nullableJson);

        expect(
          employeeRespondModel.id,
          KTestVariables.employeeRespondModelModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestVariables.employeeRespondModelModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestVariables.employeeRespondModelModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestVariables.employeeRespondModelModel.noResume,
        );
        expect(
          employeeRespondModel.resume,
          null,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          EmployeeRespondModelJsonField.email:
              KTestVariables.employeeRespondModelModel.email,
          EmployeeRespondModelJsonField.noResume:
              KTestVariables.employeeRespondModelModel.noResume,
          EmployeeRespondModelJsonField.phoneNumber:
              KTestVariables.employeeRespondModelModel.phoneNumber,
          EmployeeRespondModelJsonField.resume: [
            KTestVariables.employeeRespondModelModel.resume!.toJson(),
          ],
        };

        expect(
          () => EmployeeRespondModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final employeeRespondModelJson =
            KTestVariables.employeeRespondModelModel.toJson();

        expect(employeeRespondModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModelJson = KTestVariables
            .employeeRespondModelModel
            .copyWith(resume: null)
            .toJson();

        expect(employeeRespondModelJson, nullableJson);
      });
    });
  });
}
