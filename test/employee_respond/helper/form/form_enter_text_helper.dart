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
    itemKey: EmployeeRespondKeys.emailField,
  );

  if (email != null) {
    await tester.enterText(
      find.byKey(EmployeeRespondKeys.emailField),
      email,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.phoneNumberField,
  );

  if (phoneNumber != null) {
    await tester.enterText(
      find.byKey(EmployeeRespondKeys.phoneNumberField),
      phoneNumber,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.resumeButton,
  );

  if (addResume) {
    await tester.tap(find.byKey(EmployeeRespondKeys.resumeButton));

    await tester.pumpAndSettle();
  }

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.sendButton,
  );

  await tester.tap(find.byKey(EmployeeRespondKeys.sendButton));

  await tester.pumpAndSettle();
}
