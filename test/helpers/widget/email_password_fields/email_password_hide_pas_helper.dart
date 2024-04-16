import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

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
