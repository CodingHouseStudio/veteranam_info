import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackCorrectTextHelper(
  WidgetTester tester,
) async {
  await mobFeedbackEnterTextHelper(tester: tester, text: KTestVariables.field);

  // expect(find.byKey(KWidgetkeys.widget.mobFeedback.widget), findsNothing);
}
