import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';

Future<void> correctSaveHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
  );

  await feedbackEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    field: KTestText.field,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp500,
  );

  await feedbackBoxHelper(tester);
}
