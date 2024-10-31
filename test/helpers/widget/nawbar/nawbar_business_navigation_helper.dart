import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarBusinessNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.logo),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.logo),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.myDiscounts.name, //KRoute.businessDashboard.name,
    ),
  ).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.myDiscountsButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.myDiscountsButton),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.myDiscounts.name,
    ),
  ).called(1);
}
