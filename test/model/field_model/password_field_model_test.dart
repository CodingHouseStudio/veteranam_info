import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/field_models/field_models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

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
      const result = PasswordFieldModel.dirty(KTestVariables.shortPassword);
      expect(
        result.error,
        PasswordFieldModelValidationError.invalidLength,
      );
    });
    test('${KGroupText.shouldBe} capitalLetter', () {
      const result = PasswordFieldModel.dirty(KTestVariables.passwordIncorrect);
      expect(
        result.error,
        PasswordFieldModelValidationError.capitalLetter,
      );
    });
    test('${KGroupText.shouldBe} capitalLetter', () {
      const result =
          PasswordFieldModel.dirty(KTestVariables.passwordIncorrectNumber);
      expect(
        result.error,
        PasswordFieldModelValidationError.oneNumber,
      );
    });
    test('${KGroupText.shouldBe} correct', () {
      const result = PasswordFieldModel.dirty(KTestVariables.passwordCorrect);
      expect(
        result.error,
        null,
      );
    });
  });
}
