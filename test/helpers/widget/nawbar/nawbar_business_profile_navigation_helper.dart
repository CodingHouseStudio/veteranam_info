import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarBusinessProfileNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(NawbarKeys.logo),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(NawbarKeys.myDiscountsButton),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(NawbarKeys.loginIcon),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: NawbarKeys.loginIcon,
  );

  await tester.tap(
    find.byKey(NawbarKeys.loginIcon),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.company.name,
    ),
  ).called(1);
}
