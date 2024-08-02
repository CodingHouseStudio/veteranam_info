import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';
import '../helper.dart';

Future<void> correctSaveHelper(
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
    email: KTestText.userEmail,
    field: KTestText.field,
  );

  await dialogFailureSetHelper(tester: tester, isFailure: false);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp200,
  );

  await feedbackBoxHelper(tester: tester, exist: true);
}
