import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

Future<void> signUpUserButtonNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.userRole.userButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.userRole.userButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.signUp.name),
  ).called(1);
}
