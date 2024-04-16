import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> signUpFieldsHelper({
  required WidgetTester tester,
  required String password,
  required String email,
  required bool dataIsCorrect,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.signUp.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: email,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.signUp.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(
    tester: tester,
    showPassword: true,
  );

  await emailPasswordFieldsPasHelper(
    tester: tester,
    password: password,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.signUp.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

  await tester.pumpAndSettle();

  final passwordField = tester.widget<TextField>(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
  );
  if (dataIsCorrect) {
    expect(passwordField.decoration?.errorText, isNull);
  } else {
    expect(passwordField.decoration?.errorText, isNotNull);
  }
}
