import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> addDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.iconAdd),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.myDiscounts.iconAdd,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.myDiscounts.iconAdd));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.discountsAdd.name),
  ).called(1);
}
