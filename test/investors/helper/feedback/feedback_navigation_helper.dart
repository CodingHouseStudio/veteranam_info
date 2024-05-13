import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';

Future<void> feedbackNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await feedbackEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    field: KTestText.field,
  );

  await feedbackBoxNavigationHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
