import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

Future<void> boxProfileNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.businessDashboard.myProfielBox),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.screen.businessDashboard.myProfielBox));

  verify(
    () => mockGoRouter.goNamed(KRoute.profile.name),
  ).called(1);
}