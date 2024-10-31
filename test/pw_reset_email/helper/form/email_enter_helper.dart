import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> emailEnterHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.emailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.pwResetEmail.emailField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.pwResetEmail.emailField),
    email,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.pwResetEmail.sendButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.pwResetEmail.sendButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
