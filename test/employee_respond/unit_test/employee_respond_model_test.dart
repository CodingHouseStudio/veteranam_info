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
      EmployeeRespondModelJsonField.id: KTestText.employeeRespondModel.id,
      EmployeeRespondModelJsonField.email: KTestText.employeeRespondModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestText.employeeRespondModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestText.employeeRespondModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: [
        KTestText.employeeRespondModel.resume!.toJson(),
      ],
    };
    final nullableJson = {
      EmployeeRespondModelJsonField.id: KTestText.employeeRespondModel.id,
      EmployeeRespondModelJsonField.email: KTestText.employeeRespondModel.email,
      EmployeeRespondModelJsonField.noResume:
          KTestText.employeeRespondModel.noResume,
      EmployeeRespondModelJsonField.phoneNumber:
          KTestText.employeeRespondModel.phoneNumber,
      EmployeeRespondModelJsonField.resume: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final employeeRespondModel = EmployeeRespondModel.fromJson(fullJson);

        expect(
          employeeRespondModel.id,
          KTestText.employeeRespondModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestText.employeeRespondModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestText.employeeRespondModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestText.employeeRespondModel.noResume,
        );
        expect(
          employeeRespondModel.resume,
          KTestText.employeeRespondModel.resume,
        );
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModel =
            EmployeeRespondModel.fromJson(nullableJson);

        expect(
          employeeRespondModel.id,
          KTestText.employeeRespondModel.id,
        );
        expect(
          employeeRespondModel.email,
          KTestText.employeeRespondModel.email,
        );
        expect(
          employeeRespondModel.phoneNumber,
          KTestText.employeeRespondModel.phoneNumber,
        );
        expect(
          employeeRespondModel.noResume,
          KTestText.employeeRespondModel.noResume,
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
              KTestText.employeeRespondModel.email,
          EmployeeRespondModelJsonField.noResume:
              KTestText.employeeRespondModel.noResume,
          EmployeeRespondModelJsonField.phoneNumber:
              KTestText.employeeRespondModel.phoneNumber,
          EmployeeRespondModelJsonField.resume: [
            KTestText.employeeRespondModel.resume!.toJson(),
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
            KTestText.employeeRespondModel.toJson();

        expect(employeeRespondModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final employeeRespondModelJson =
            KTestText.employeeRespondModel.copyWith(resume: null).toJson();

        expect(employeeRespondModelJson, nullableJson);
      });
    });
  });
}
