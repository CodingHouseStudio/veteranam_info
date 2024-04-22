import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> signUpFieldsHelper({
  required WidgetTester tester,
  required String password,
  required String email,
  required bool dataIsCorrect,
  required MockGoRouter mockGoRouter,
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

  if (dataIsCorrect) {
    verify(() => mockGoRouter.goNamed(KRoute.home.name)).called(1);
  } else {
    verifyNever(() => mockGoRouter.goNamed(KRoute.home.name));
  }
}
