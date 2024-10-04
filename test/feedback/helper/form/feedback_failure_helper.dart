import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> feedbackFailureHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await feedbackEnterTextHelper(
        tester: tester,
        email: KTestText.userEmail,
        name: KTestText.nameCorrect,
        field: KTestText.field,
      );

      await dialogSnackBarTextHelper(tester: tester);
    },
  );
}
