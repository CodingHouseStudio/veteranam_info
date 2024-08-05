import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
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
  final list = tester.widgetList(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterList),
  );
  if (list.isEmpty) {
    await tester
        .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterButton));

    await tester.pumpAndSettle();
  }

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterList),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterText),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.discountText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.discountItems),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.cityText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester, twiceTap: true);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsOneWidget,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    tapItemLast: true,
    hasAmount: true,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton));

  await tester.pumpAndSettle();

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: KWidgetkeys.screen.discounts.advancedFilterList,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.appliedFilterItems),
    findsNothing,
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

    await tester.tapAt(Offset.zero);
  } else {
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
