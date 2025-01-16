import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/user_role/view/user_role_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> userRolePumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const UserRoleScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(UserRoleKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
