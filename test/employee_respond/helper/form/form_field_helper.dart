import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> formFieldHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.employeeRespond.emailField),
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
    find.byKey(KWidgetkeys.screen.employeeRespond.resumeButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.resumeButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.employeeRespond.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
