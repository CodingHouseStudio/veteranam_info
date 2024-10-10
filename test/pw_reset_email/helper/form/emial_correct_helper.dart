import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> emailCorrectHelper(
  WidgetTester tester,
) async {
  await emailEnterHelper(tester: tester, email: KTestText.userEmail);

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.delayText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendButton),
    findsNothing,
  );

  await tester.pumpAndSettle(const Duration(minutes: 2));

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.delayText),
    findsNothing,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.pwResetEmail.resendButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.delayText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendButton),
    findsNothing,
  );
}
