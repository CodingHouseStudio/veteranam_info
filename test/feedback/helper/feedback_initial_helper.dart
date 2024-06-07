import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

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

      expect(
        find.byKey(KWidgetkeys.screen.feedback.titleIcon),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.nameField),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.feedback.nameField,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.emailButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.messageField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.buttonText),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.screen.feedback.button), findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.screen.feedback.emailText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.emailButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.socialText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.linkedIn),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.instagram),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.facebook),
        findsOneWidget,
      );

      await feedbackBoxHelper(tester: tester, exist: false);
    },
  );
}
