import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';
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
        field: KTestText.field,
      );

      await dialogFailureSetHelper(tester: tester);
    },
  );
}
