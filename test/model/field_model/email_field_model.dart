import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('Email ${KGroupText.fiedlModel}  ${KGroupText.validationError}', () {
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
}