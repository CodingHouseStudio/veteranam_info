import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dropDownButtonHelper({
  required WidgetTester tester,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.dropDownButton.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropDownButton.loginButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropDownButton.loginButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.userRole.loginBusinessButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.userRole.loginUserButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropDownButton.loginButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();
}
