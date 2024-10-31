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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
  );

  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldEmail),
    dataIsCorrect ? findsOneWidget : findsNothing,
  );
  expect(
    find.byKey(KWidgetkeys.widget.emailPasswordFields.fieldPassword),
    dataIsCorrect ? findsNothing : findsOneWidget,
  );
}
