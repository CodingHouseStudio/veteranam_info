import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackWrongTextHelper(
  WidgetTester tester,
) async {
  await mobFeedbackEnterTextHelper(tester: tester, text: KTestText.fieldEmpty);

  await mobFeedbackHelper(tester);
}
