import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discounts.advancedFilter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilter),
    findsOneWidget,
  );
  // final advancedButton = tester.widgetList(
  //   find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton),
  // );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton),
    findsOneWidget,
  );

  // if (advancedButton.isNotEmpty) {
  await tester
      .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton));

  await tester.pumpAndSettle();
  // }
  if (find
      .byKey(KWidgetkeys.screen.discounts.advancedFilterList)
      .evaluate()
      .isEmpty) {
    await tester
        .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton));

    await tester.pumpAndSettle();
  }

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterList),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterText),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.discountText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.discountItems),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.cityText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester, twiceTap: true);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsOneWidget,
  );

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

  await chekPointSignleTapHelper(
    tester: tester,
    index: 1,
    hasAmount: true,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems).last,
    warnIfMissed: false,
  );

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

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton),
    findsOneWidget,
  );

  final isMobile = tester
      .widgetList(find.byKey(KWidgetkeys.screen.discounts.advancedFilterDialog))
      .isNotEmpty;

  if (isMobile) {
    // expect(
    //   find.byKey(KWidgetkeys.screen.discounts.cancelIcon),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterDialog),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterMobAppliedButton),
      findsOneWidget,
    );
  } else {
    await tester.tap(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton),
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterButtonIcon),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton),
      findsOneWidget,
    );

    await tester
        .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton));

    await tester.pumpAndSettle();

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterList),
      findsNothing,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discounts.advancedFilterButtonIconUp),
      findsOneWidget,
    );
  }
}
