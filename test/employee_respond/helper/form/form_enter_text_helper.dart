import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> formEnterTextHelper({
  required WidgetTester tester,
  required String? phoneNumber,
  required String? email,
  bool addResume = true,
}) async {
  await formFieldHelper(tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.emailField,
  );

  if (email != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.employeeRespond.emailField),
      email,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.phoneNumberField,
  );

  if (phoneNumber != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.employeeRespond.phoneNumberField),
      phoneNumber,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.resumeButton,
  );

  if (addResume) {
    await tester
        .tap(find.byKey(KWidgetkeys.screen.employeeRespond.resumeButton));

    await tester.pumpAndSettle();
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.sendButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.employeeRespond.sendButton));

  await tester.pumpAndSettle();
}
