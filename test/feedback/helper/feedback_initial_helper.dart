import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'form/feedback_form_initial_helper.dart';

Future<void> feedbackInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      // if (!Config.isWeb) {
      //   expect(
      //     find.byKey(NawbarKeys.pageName),
      //     findsOneWidget,
      //   );
      // }
      // expect(
      //   find.byKey(FeedbackKeys.pointText),
      //   findsOneWidget,
      // );

      expect(find.byKey(FeedbackKeys.title), findsOneWidget);

      // expect(
      //   find.byKey(FeedbackKeys.titleIcon),
      //   findsOneWidget,
      // );

      await feedbackFormInitialHelper(
        tester,
      );
    },
  );
}
