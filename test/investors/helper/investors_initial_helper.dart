import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  await feedbackEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    field: KTestText.field,
  );

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await feedbackBoxHelper(tester);
}
