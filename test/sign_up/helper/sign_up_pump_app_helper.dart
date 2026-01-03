import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/sign_up/view/sign_up_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> signUpPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const SignUpScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(SignUpKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
