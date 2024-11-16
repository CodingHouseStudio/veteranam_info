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
    find.byKey(KWidgetkeys.widget.nawbar.logo),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.nawbar.myDiscountsButton),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: KWidgetkeys.widget.nawbar.loginIcon,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.company.name,
    ),
  ).called(1);
}
