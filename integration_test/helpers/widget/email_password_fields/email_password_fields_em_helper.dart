import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> emailPasswordFieldsEmHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldEmail),
    findsWidgets,
  );

  // expect(
  //   find.byKey(EmailPasswordFieldsKeys.textEmail),
  //   findsWidgets,
  // );

  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldPassword),
    findsNothing,
  );

  // expect(
  //   find.byKey(EmailPasswordFieldsKeys.textPassword),
  //   findsNothing,
  // );

  await tester.enterText(
    find.byKey(EmailPasswordFieldsKeys.fieldEmail),
    email,
  );

  expect(
    find.text(email),
    findsWidgets,
  );
}
