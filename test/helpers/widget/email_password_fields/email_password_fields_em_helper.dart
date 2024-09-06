import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> emailPasswordFieldsEmHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
    findsWidgets,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
  //   findsWidgets,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
    findsNothing,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
  //   findsNothing,
  // );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
    email,
  );

  expect(
    find.text(email),
    findsWidgets,
  );
}
