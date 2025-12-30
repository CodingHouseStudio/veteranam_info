import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> emailEnterHelper({
  required WidgetTester tester,
  required String email,
}) async {
  expect(
    find.byKey(PwResetEmailKeys.emailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PwResetEmailKeys.emailField,
  );

  await tester.enterText(
    find.byKey(PwResetEmailKeys.emailField),
    email,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(PwResetEmailKeys.sendButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PwResetEmailKeys.sendButton,
  );

  await tester.tap(find.byKey(PwResetEmailKeys.sendButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
