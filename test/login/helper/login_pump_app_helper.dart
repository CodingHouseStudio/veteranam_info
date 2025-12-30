import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/login/view/login_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> loginPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const LoginScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(LoginKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
