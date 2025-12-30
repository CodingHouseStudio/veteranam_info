import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> emailCorrectHelper(
  WidgetTester tester,
) async {
  await emailEnterHelper(tester: tester, email: KTestVariables.userEmail);

  expect(
    find.byKey(PwResetEmailKeys.resendSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.cancelButton),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.delayText),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.resendButton),
    findsNothing,
  );

  await tester.pumpAndSettle(const Duration(minutes: 2));

  expect(
    find.byKey(PwResetEmailKeys.resendText),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.resendButton),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.delayText),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: PwResetEmailKeys.cancelButton,
  );

  await tester.tap(find.byKey(PwResetEmailKeys.resendButton));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: PwResetEmailKeys.cancelButton,
  );

  expect(
    find.byKey(PwResetEmailKeys.resendButton),
    findsNothing,
  );

  expect(
    find.byKey(PwResetEmailKeys.delayText),
    findsOneWidget,
  );

  expect(
    find.byKey(PwResetEmailKeys.resendButton),
    findsNothing,
  );
}
