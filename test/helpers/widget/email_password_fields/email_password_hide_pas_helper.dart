import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> emailPasswordFieldsHidePasHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(EmailPasswordFieldsKeys.buttonHidePassword),
  );

  await tester.pumpAndSettle();
}
