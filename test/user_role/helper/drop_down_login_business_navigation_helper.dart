import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> dropDownLoginBusinessNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await userRoleLoginButtonNavigationHelper(
    mockGoRouter: mockGoRouter,
    tester: tester,
  );

  expect(
    find.byKey(UserRoleKeys.loginBusinessButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(UserRoleKeys.loginBusinessButton));

  await tester.pumpAndSettle();
}
