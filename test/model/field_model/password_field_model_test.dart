import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('Password ${KGroupText.fiedlModel} ${KGroupText.validationError}', () {
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
}