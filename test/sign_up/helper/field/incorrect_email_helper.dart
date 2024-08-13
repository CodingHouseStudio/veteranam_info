import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> incorrectEmailHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.signUp.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestText.userEmailIncorrect,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(
    tester: tester,
    showPassword: false,
  );

  await dialogSnackBarTextHelper(tester: tester, showDialog: false);
}
