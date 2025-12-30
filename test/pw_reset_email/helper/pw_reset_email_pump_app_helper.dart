import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/pw_reset_email/view/pw_reset_email_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> pwResetEmailPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const PwResetEmailScreen(
      email: KTestVariables.userEmailIncorrect,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(PwResetEmailKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
