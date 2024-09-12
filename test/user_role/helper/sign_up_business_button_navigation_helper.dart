import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

// Helper function for navigating using the user button
Future<void> signUpButtonsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool isUser,
}) async {
  if (isUser) {
    expect(
      find.byKey(KWidgetkeys.screen.userRole.userButton),
      findsOneWidget,
    );

    await tester.tap(find.byKey(KWidgetkeys.screen.userRole.userButton));

    verify(
      () => mockGoRouter.goNamed(KRoute.signUp.name),
    ).called(1);
  } else {
    expect(
      find.byKey(KWidgetkeys.screen.userRole.businessButton),
      findsOneWidget,
    );

    await tester.tap(find.byKey(KWidgetkeys.screen.userRole.businessButton));

    await tester.pumpAndSettle();

    // Uncomment the following lines if you want to verify the route change
    // verify(
    //   () => mockGoRouter.goNamed(KRoute.signUp.name),
    // ).called(1);
  }
}
