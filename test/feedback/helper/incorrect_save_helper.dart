import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> incorrectSaveHelper(
  WidgetTester tester,
) async {
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
    email: KTestVariables.userEmailIncorrect,
    name: KTestVariables.nameIncorrect,
    field: KTestVariables.field,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
    itemKey: KWidgetkeys.screen.feedback.title,
  );

  await feedbackInitialHelper(tester);
}
