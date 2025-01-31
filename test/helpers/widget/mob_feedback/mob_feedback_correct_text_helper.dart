import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackCorrectTextHelper(
  WidgetTester tester,
) async {
  await mobFeedbackEnterTextHelper(
    tester: tester,
    message: KTestVariables.field,
    email: KTestVariables.userEmail,
  );

  // expect(find.byKey(MobFeedbackKeys.widget), findsNothing);
}
