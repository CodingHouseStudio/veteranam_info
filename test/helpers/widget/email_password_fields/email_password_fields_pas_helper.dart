import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> emailPasswordFieldsPasHelper({
  required WidgetTester tester,
  required String password,
}) async {
  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldEmail),
    findsNothing,
  );

  // expect(
  //   find.byKey(EmailPasswordFieldsKeys.textEmail),
  //   findsNothing,
  // );

  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldPassword),
    findsWidgets,
  );

  // expect(
  //   find.byKey(EmailPasswordFieldsKeys.textPassword),
  //   findsWidgets,
  // );

  await tester.enterText(
    find.byKey(EmailPasswordFieldsKeys.fieldPassword),
    password,
  );

  expect(
    find.text(password),
    findsWidgets,
  );
}
