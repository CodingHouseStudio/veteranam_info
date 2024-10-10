import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> emailFailureHelper(
  WidgetTester tester,
) async {
  await emailEnterHelper(tester: tester, email: KTestText.userEmail);

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.submitingText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendSubtitle),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.delayText),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.pwResetEmail.resendButton),
    findsNothing,
  );
}
