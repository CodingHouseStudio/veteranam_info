import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

// Helper function for navigating using the user button
Future<void> signUpButtonsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(UserRoleKeys.signUpBusinessButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: UserRoleKeys.signUpBusinessButton,
  );

  await tester.tap(find.byKey(UserRoleKeys.signUpBusinessButton));

  await tester.pumpAndSettle();

  // Uncomment the following lines if you want to verify the route change
  // verify(
  //   () => mockGoRouter.goNamed(KRoute.signUp.name),
  // ).called(1);

  expect(
    find.byKey(UserRoleKeys.signUpUserButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(UserRoleKeys.signUpUserButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.signUp.name),
  ).called(1);
}
