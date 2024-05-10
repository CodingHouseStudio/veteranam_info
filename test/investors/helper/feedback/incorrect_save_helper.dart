import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';

Future<void> incorrectSaveHelper(
  WidgetTester tester,
) async {
  await feedbackEnterTextHelper(
    tester: tester,
    email: KTestText.userEmailIncorrect,
    field: KTestText.field,
  );

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await feedbackHelper(tester);
}
