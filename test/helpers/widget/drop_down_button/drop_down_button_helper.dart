import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> dropDownButtonHelper({
  required WidgetTester tester,
}) async {
  expect(
    find.byKey(DropDownButtonKeys.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(DropDownButtonKeys.loginButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(DropDownButtonKeys.loginButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(UserRoleKeys.loginBusinessButton),
    findsOneWidget,
  );

  expect(
    find.byKey(UserRoleKeys.loginUserButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(DropDownButtonKeys.loginButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();
}
