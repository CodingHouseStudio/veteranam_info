import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> formFieldHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(EmployeeRespondKeys.emailField),
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
    find.byKey(EmployeeRespondKeys.resumeButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.resumeButton,
  );

  expect(
    find.byKey(EmployeeRespondKeys.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
