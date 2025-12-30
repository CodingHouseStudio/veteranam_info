import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> passwordEnterHelper({
  required WidgetTester tester,
  required String password,
  required String confirmPassword,
}) async {
  expect(
    find.byKey(PasswordResetKeys.passwordField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PasswordResetKeys.passwordField,
  );

  await tester.enterText(
    find.byKey(PasswordResetKeys.passwordField),
    password,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(PasswordResetKeys.confirmPasswordField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PasswordResetKeys.confirmPasswordField,
  );

  await tester.enterText(
    find.byKey(PasswordResetKeys.confirmPasswordField),
    confirmPassword,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(PasswordResetKeys.confirmButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PasswordResetKeys.confirmButton,
  );

  await tester.tap(find.byKey(PasswordResetKeys.confirmButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
