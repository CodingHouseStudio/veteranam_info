import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/password_reset/view/password_reset_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> passwordResetPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
  String? code = KTestVariables.code,
}) async {
  await tester.pumpApp(
    PasswordResetScreen(
      code: code,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(PasswordResetKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
