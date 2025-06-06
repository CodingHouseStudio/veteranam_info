import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> incorrectEmailHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(LoginKeys.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestVariables.userEmailIncorrect,
  );

  await tester.tap(find.byKey(LoginKeys.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(
    tester: tester,
    showPassword: false,
  );

  await dialogSnackBarTextHelper(tester: tester, showDialog: false);
}
