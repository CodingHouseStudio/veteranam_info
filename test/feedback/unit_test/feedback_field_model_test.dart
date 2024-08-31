import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.feedback} ${KGroupText.fiedlModel} ', () {
    group('Name ${KGroupText.validationError}', () {
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = NameFieldModel.pure();
        expect(result.error, NameFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = NameFieldModel.dirty();
        expect(result.error, NameFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
        const result = NameFieldModel.dirty(KTestText.field);
        expect(result.error, null);
      });
    });
    group('Email ${KGroupText.validationError}', () {
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = EmailFieldModel.pure();
        expect(result.error, EmailFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = EmailFieldModel.dirty();
        expect(result.error, EmailFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
        const result = EmailFieldModel.dirty(KTestText.field);
        expect(result.error, isNot(EmailFieldModelValidationError.empty));
      });
      test('${KGroupText.shouldBe} invalidLength', () {
        const result = EmailFieldModel.dirty(KTestText.shortUserEmail);
        expect(result.error, EmailFieldModelValidationError.invalidLength);
      });
      test('${KGroupText.shouldNotBe} invalidLength', () {
        const result = EmailFieldModel.dirty(KTestText.userEmailIncorrect);
        expect(
          result.error,
          isNot(EmailFieldModelValidationError.invalidLength),
        );
      });
      test('${KGroupText.shouldBe} wrong', () {
        const result = EmailFieldModel.dirty(KTestText.userEmailIncorrect);
        expect(result.error, EmailFieldModelValidationError.wrong);
      });
      test('${KGroupText.shouldNotBe} invalidLength', () {
        const result = EmailFieldModel.dirty(KTestText.userEmail);
        expect(
          result.error,
          null,
        );
      });
    });
    group('Message ${KGroupText.validationError}', () {
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = MessageFieldModel.pure();
        expect(result.error, MessageFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = MessageFieldModel.dirty();
        expect(result.error, MessageFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
        const result = MessageFieldModel.dirty(KTestText.field);
        expect(result.error, isNot(MessageFieldModelValidationError.empty));
      });
    });
  });
}
