import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.workEmployee} ${KGroupText.model} ', () {
    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.workModelItems.first.id,
        'title': KTestText.workModelItems.first.title,
        'price': KTestText.workModelItems.first.price,
        'employerContact': KTestText.workModelItems.first.employerContact,
        'companyName': KTestText.workModelItems.first.companyName,
        'description': KTestText.workModelItems.first.description,
        'category': KTestText.workModelItems.first.category,
        'city': KTestText.workModelItems.first.city,
        'remote': KTestText.workModelItems.first.remote,
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

    test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
      final json = {
        'id': KTestText.workModelItems.first.id,
        'title': KTestText.workModelItems.first.title,
        'price': KTestText.workModelItems.first.price,
        'employerContact': KTestText.workModelItems.first.employerContact,
        'companyName': KTestText.workModelItems.first.companyName,
        'description': KTestText.workModelItems.first.description,
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

    test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
      final json = {
        'title': KTestText.workModelItems.first.title,
        'price': KTestText.workModelItems.first.price,
        'employerContact': KTestText.workModelItems.first.employerContact,
        'companyName': KTestText.workModelItems.first.companyName,
        'description': KTestText.workModelItems.first.description,
      };

      expect(
        () => WorkModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
