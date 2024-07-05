import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.authentication} ${KGroupText.fiedlModel} ', () {
    group('Password ${KGroupText.validationError}', () {
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = PasswordFieldModel.pure();
        expect(result.error, PasswordFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
        const result = PasswordFieldModel.dirty();
        expect(result.error, PasswordFieldModelValidationError.empty);
      });
      test('${KGroupText.shouldBe} invalidLength', () {
        const result = PasswordFieldModel.dirty(KTestText.shortPassword);
        expect(
          result.error,
          PasswordFieldModelValidationError.invalidLength,
        );
      });
      test('${KGroupText.shouldBe} capitalLetter', () {
        const result = PasswordFieldModel.dirty(KTestText.passwordIncorrect);
        expect(
          result.error,
          PasswordFieldModelValidationError.capitalLetter,
        );
      });
      test('${KGroupText.shouldBe} capitalLetter', () {
        const result =
            PasswordFieldModel.dirty(KTestText.passwordIncorrectNumber);
        expect(
          result.error,
          PasswordFieldModelValidationError.oneNumber,
        );
      });
      test('${KGroupText.shouldBe} correct', () {
        const result = PasswordFieldModel.dirty(KTestText.passwordCorrect);
        expect(
          result.error,
          null,
        );
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
