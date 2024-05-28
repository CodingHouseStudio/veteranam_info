import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/models/models.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.workEmployee} ${KGroupText.model} ', () {
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          WorkModelJsonField.id: KTestText.workModelItems.first.id,
          WorkModelJsonField.title: KTestText.workModelItems.first.title,
          WorkModelJsonField.price: KTestText.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestText.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestText.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestText.workModelItems.first.description,
          WorkModelJsonField.category: KTestText.workModelItems.first.category,
          WorkModelJsonField.city: KTestText.workModelItems.first.city,
          WorkModelJsonField.remote: KTestText.workModelItems.first.remote,
        };

        final workModel = WorkModel.fromJson(json);

        expect(
          workModel.id,
          KTestText.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestText.workModelItems.first.title,
        );
        expect(
          workModel.category,
          KTestText.workModelItems.first.category,
        );
        expect(
          workModel.city,
          KTestText.workModelItems.first.city,
        );
        expect(
          workModel.companyName,
          KTestText.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestText.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestText.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestText.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          KTestText.workModelItems.first.remote,
        );
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          WorkModelJsonField.id: KTestText.workModelItems.first.id,
          WorkModelJsonField.title: KTestText.workModelItems.first.title,
          WorkModelJsonField.price: KTestText.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestText.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestText.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestText.workModelItems.first.description,
        };

        final workModel = WorkModel.fromJson(json);

        expect(
          workModel.id,
          KTestText.workModelItems.first.id,
        );
        expect(
          workModel.title,
          KTestText.workModelItems.first.title,
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
          KTestText.workModelItems.first.companyName,
        );
        expect(
          workModel.description,
          KTestText.workModelItems.first.description,
        );
        expect(
          workModel.employerContact,
          KTestText.workModelItems.first.employerContact,
        );
        expect(
          workModel.price,
          KTestText.workModelItems.first.price,
        );
        expect(
          workModel.remote,
          false,
        );
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          WorkModelJsonField.title: KTestText.workModelItems.first.title,
          WorkModelJsonField.price: KTestText.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestText.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestText.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestText.workModelItems.first.description,
        };

        expect(
          () => WorkModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          WorkModelJsonField.id: KTestText.workModelItems.first.id,
          WorkModelJsonField.title: KTestText.workModelItems.first.title,
          WorkModelJsonField.price: KTestText.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestText.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestText.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestText.workModelItems.first.description,
          WorkModelJsonField.category: KTestText.workModelItems.first.category,
          WorkModelJsonField.city: KTestText.workModelItems.first.city,
          WorkModelJsonField.remote: KTestText.workModelItems.first.remote,
        };

        final workModelJson = KTestText.workModelItems.first.toJson();

        expect(workModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          WorkModelJsonField.id: KTestText.workModelItems.first.id,
          WorkModelJsonField.title: KTestText.workModelItems.first.title,
          WorkModelJsonField.price: KTestText.workModelItems.first.price,
          WorkModelJsonField.employerContact:
              KTestText.workModelItems.first.employerContact,
          WorkModelJsonField.companyName:
              KTestText.workModelItems.first.companyName,
          WorkModelJsonField.description:
              KTestText.workModelItems.first.description,
          WorkModelJsonField.category: null,
          WorkModelJsonField.city: null,
          WorkModelJsonField.remote: KTestText.workModelItems.first.remote,
        };

        final workModelJson = KTestText.workModelItems.first
            .copyWith(category: null, city: null)
            .toJson();

        expect(workModelJson, json);
      });
    });
  });
}
