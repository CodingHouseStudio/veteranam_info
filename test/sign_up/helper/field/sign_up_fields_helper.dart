import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> signUpFieldsHelper({
  required WidgetTester tester,
  required String password,
  required String email,
  required bool dataIsCorrect,
}) async {
  expect(
    find.byKey(SignUpKeys.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: email,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: SignUpKeys.button,
  );

  await tester.tap(find.byKey(SignUpKeys.button));

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
    itemKey: SignUpKeys.button,
  );

  await tester.tap(find.byKey(SignUpKeys.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
  );

  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldEmail),
    dataIsCorrect ? findsOneWidget : findsNothing,
  );
  expect(
    find.byKey(EmailPasswordFieldsKeys.fieldPassword),
    dataIsCorrect ? findsNothing : findsOneWidget,
  );
}
