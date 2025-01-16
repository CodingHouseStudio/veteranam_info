import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> employeeRespondInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(EmployeeRespondKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.username),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.emailText),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.emailField),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.phoneNumberText),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.phoneNumberField),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: EmployeeRespondKeys.phoneNumberField,
      );

      expect(
        find.byKey(EmployeeRespondKeys.resumeText),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.resumeButton),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.checkWithoutResume),
        findsOneWidget,
      );

      await chekPointHelper(tester: tester);

      // expect(
      //   find.byKey(EmployeeRespondKeys.noResume),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(EmployeeRespondKeys.sendButton),
        findsOneWidget,
      );

      expect(
        find.byKey(EmployeeRespondKeys.cancelButton),
        findsOneWidget,
      );
    },
  );
}
