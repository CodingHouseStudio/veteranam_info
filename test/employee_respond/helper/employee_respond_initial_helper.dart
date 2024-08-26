import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> employeeRespondInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.username),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.emailText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.emailField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberField),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.employeeRespond.phoneNumberField,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.resumeText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.resumeButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.checkWithoutResume),
        findsOneWidget,
      );

      await chekPointHelper(tester: tester);

      // expect(
      //   find.byKey(KWidgetkeys.screen.employeeRespond.noResume),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.sendButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.employeeRespond.cancelButton),
        findsOneWidget,
      );
    },
  );
}
