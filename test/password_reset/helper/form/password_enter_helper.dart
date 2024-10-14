import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> passwordEnterHelper({
  required WidgetTester tester,
  required String password,
  required String confirmPassword,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.passwordField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.passwordReset.passwordField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.passwordReset.passwordField),
    password,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.confirmPasswordField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.passwordReset.confirmPasswordField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.passwordReset.confirmPasswordField),
    confirmPassword,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.passwordReset.confirmButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.passwordReset.confirmButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.passwordReset.confirmButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
