import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> loginFormNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(LoginKeys.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestVariables.userEmail,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: LoginKeys.button,
  );

  await tester.tap(find.byKey(LoginKeys.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsNavigationHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
