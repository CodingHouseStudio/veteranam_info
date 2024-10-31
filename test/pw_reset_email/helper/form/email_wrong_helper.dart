import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> emailWrongHelper(
  WidgetTester tester,
) async {
  await emailEnterHelper(
    tester: tester,
    email: KTestText.emailModelWrong.email,
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
