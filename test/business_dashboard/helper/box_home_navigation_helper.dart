import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';
import '../../test_mocks/go_router_provider_mocks.dart';

Future<void> boxMyDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(BusinessDashboardKeys.myDiscountsBox),
    findsOneWidget,
  );

  await tester.tap(find.byKey(BusinessDashboardKeys.myDiscountsBox));

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}
