import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> dropDownLoginUserNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await dropDownButtonNavigationHelper(
    mockGoRouter: mockGoRouter,
    tester: tester,
  );

  expect(
    find.byKey(KWidgetkeys.screen.userRole.loginUserButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.userRole.loginUserButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.login.name),
  ).called(1);
}
