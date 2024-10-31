import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> emailPasswordFieldsHidePasHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.buttonHidePassword),
  );

  await tester.pumpAndSettle();
}
