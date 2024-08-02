import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';
import 'form/feedback_form_initial_helper.dart';

Future<void> feedbackInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.feedback.pointText),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.screen.feedback.title), findsOneWidget);

      // expect(
      //   find.byKey(KWidgetkeys.screen.feedback.titleIcon),
      //   findsOneWidget,
      // );

      await feedbackFormInitialHelper(
        tester,
      );
    },
  );
}
