import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> advancedFilterResetMobHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discounts.advancedFilter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilter),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton));

  await tester.pumpAndSettle();

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    index: 3,
    hasAmount: true,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    index: 2,
    hasAmount: true,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton),
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
  //   findsNothing,
  // );

  verify(() => mockGoRouter.pop()).called(1);
}
