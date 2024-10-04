import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
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
    name: KTestText.nameCorrect,
    field: KTestText.field,
  );

  await dialogSnackBarTextHelper(tester: tester, showDialog: false);

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
