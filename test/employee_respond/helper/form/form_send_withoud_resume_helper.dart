import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> formWithoundResumeSendHelper(
  WidgetTester tester,
) async {
  await formEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    phoneNumber: KTestText.phoneNumber,
    addResume: false,
  );

  expect(
    find.byKey(KWidgetkeys.screen.employeeRespond.checkWithoutResume),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.checkWithoutResume,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.screen.employeeRespond.checkWithoutResume),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.sendButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.employeeRespond.sendButton));

  await tester.pumpAndSettle();
}
