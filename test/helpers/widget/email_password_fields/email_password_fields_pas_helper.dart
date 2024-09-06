import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> emailPasswordFieldsPasHelper({
  required WidgetTester tester,
  required String password,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
    findsNothing,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textEmail),
  //   findsNothing,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
    findsWidgets,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.emailPasswordFields.textPassword),
  //   findsWidgets,
  // );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
    password,
  );

  expect(
    find.text(password),
    findsWidgets,
  );
}
