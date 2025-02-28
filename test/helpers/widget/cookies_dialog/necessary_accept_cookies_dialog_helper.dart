import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> cookiesAcceptNecessaryDialogHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(CookiesDialogKeys.dialog),
    findsOneWidget,
  );

  expect(
    find.byKey(CookiesDialogKeys.text),
    findsOneWidget,
  );

  expect(
    find.byKey(CookiesDialogKeys.acceptButton),
    findsOneWidget,
  );

  expect(
    find.byKey(CookiesDialogKeys.acceptNecessaryButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(CookiesDialogKeys.acceptNecessaryButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(CookiesDialogKeys.dialog),
    findsNothing,
  );
}
