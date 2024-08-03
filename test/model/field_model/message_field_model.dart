import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

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
      const result = MessageFieldModel.dirty(KTestText.field);
      expect(result.error, isNot(MessageFieldModelValidationError.empty));
    });
  });
}
