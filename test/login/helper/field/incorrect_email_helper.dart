import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> incorrectEmailHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.login.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestText.userEmailIncorrect,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.login.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsHelper(
    tester: tester,
    showPassword: false,
  );

  await dialogFailureSetHelper(tester: tester, isFailure: false);
}
