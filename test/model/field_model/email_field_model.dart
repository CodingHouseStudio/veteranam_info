import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/field_models/field_models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

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
      const result = EmailFieldModel.dirty(KTestVariables.field);
      expect(result.error, isNot(EmailFieldModelValidationError.empty));
    });
    test('${KGroupText.shouldBe} invalidLength', () {
      const result = EmailFieldModel.dirty(KTestVariables.shortUserEmail);
      expect(result.error, EmailFieldModelValidationError.invalidLength);
    });
    test('${KGroupText.shouldNotBe} invalidLength', () {
      const result = EmailFieldModel.dirty(KTestVariables.userEmailIncorrect);
      expect(
        result.error,
        isNot(EmailFieldModelValidationError.invalidLength),
      );
    });
    test('${KGroupText.shouldBe} wrong', () {
      const result = EmailFieldModel.dirty(KTestVariables.userEmailIncorrect);
      expect(result.error, EmailFieldModelValidationError.wrong);
    });
    test('${KGroupText.shouldNotBe} invalidLength', () {
      const result = EmailFieldModel.dirty(KTestVariables.userEmail);
      expect(
        result.error,
        null,
      );
    });
  });
}
