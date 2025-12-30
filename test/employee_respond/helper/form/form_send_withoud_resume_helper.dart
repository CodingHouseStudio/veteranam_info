import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> formWithoundResumeSendHelper(
  WidgetTester tester,
) async {
  await formEnterTextHelper(
    tester: tester,
    email: KTestVariables.userEmail,
    phoneNumber: KTestVariables.phoneNumber,
    addResume: false,
  );

  expect(
    find.byKey(EmployeeRespondKeys.checkWithoutResume),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.checkWithoutResume,
  );

  await tester.tap(
    find.byKey(EmployeeRespondKeys.checkWithoutResume),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.sendButton,
  );

  await tester.tap(find.byKey(EmployeeRespondKeys.sendButton));

  await tester.pumpAndSettle();
}
