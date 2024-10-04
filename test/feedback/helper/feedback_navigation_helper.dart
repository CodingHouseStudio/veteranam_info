import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> feedbackNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1500,
  );

  await feedbackEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    name: KTestText.nameCorrect,
    field: KTestText.field,
  );

  await feedbackBoxNavigationHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
