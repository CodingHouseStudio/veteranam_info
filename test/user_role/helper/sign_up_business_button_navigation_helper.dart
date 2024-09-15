import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

// Helper function for navigating using the user button
Future<void> signUpButtonsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.userRole.signUpBusinessButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.screen.userRole.signUpBusinessButton));

  await tester.pumpAndSettle();

  // Uncomment the following lines if you want to verify the route change
  // verify(
  //   () => mockGoRouter.goNamed(KRoute.signUp.name),
  // ).called(1);

  expect(
    find.byKey(KWidgetkeys.screen.userRole.signUpUserButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.userRole.signUpUserButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.signUp.name),
  ).called(1);
}
