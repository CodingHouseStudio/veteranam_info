import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/shared/models/field_models/field_models.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('Message ${KGroupText.fiedlModel} ${KGroupText.validationError}', () {
    test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
      const result = MessageFieldModel.pure();
      expect(result.error, MessageFieldModelValidationError.empty);
    });
    test('${KGroupText.shouldBe} ${KGroupText.empty}', () {
      const result = MessageFieldModel.dirty();
      expect(result.error, MessageFieldModelValidationError.empty);
    });
    test('${KGroupText.shouldNotBe} ${KGroupText.empty}', () {
      const result = MessageFieldModel.dirty(KTestVariables.field);
      expect(result.error, isNot(MessageFieldModelValidationError.empty));
    });
  });
}
