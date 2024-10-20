import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.employeeRespond} ${KGroupText.model} ', () {
    final fullJson = {
      EmployeeRespondModelJsonField.id: KTestText.employeeRespondModelModel.id,
      EmployeeRespondModelJsonField.email:
          KTestText.employeeRespondModelModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestText.employeeRespondModelModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestText.employeeRespondModelModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: [
        KTestText.employeeRespondModelModel.resume!.toJson(),
      ],
    };
    final nullableJson = {
      EmployeeRespondModelJsonField.id: KTestText.employeeRespondModelModel.id,
      EmployeeRespondModelJsonField.email:
          KTestText.employeeRespondModelModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestText.employeeRespondModelModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestText.employeeRespondModelModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final employeeRespondModel = EmployeeRespondModel.fromJson(fullJson);

        expect(
          employeeRespondModel.id,
          KTestText.employeeRespondModelModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestText.employeeRespondModelModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestText.employeeRespondModelModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestText.employeeRespondModelModel.noResume,
        );
        expect(
          employeeRespondModel.resume,
          KTestText.employeeRespondModelModel.resume,
        );
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModel =
            EmployeeRespondModel.fromJson(nullableJson);

        expect(
          employeeRespondModel.id,
          KTestText.employeeRespondModelModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestText.employeeRespondModelModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestText.employeeRespondModelModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestText.employeeRespondModelModel.noResume,
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
              KTestText.employeeRespondModelModel.email,
          EmployeeRespondModelJsonField.noResume:
              KTestText.employeeRespondModelModel.noResume,
          EmployeeRespondModelJsonField.phoneNumber:
              KTestText.employeeRespondModelModel.phoneNumber,
          EmployeeRespondModelJsonField.resume: [
            KTestText.employeeRespondModelModel.resume!.toJson(),
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
            KTestText.employeeRespondModelModel.toJson();

        expect(employeeRespondModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModelJson =
            KTestText.employeeRespondModelModel.copyWith(resume: null).toJson();

        expect(employeeRespondModelJson, nullableJson);
      });
    });
  });
}
