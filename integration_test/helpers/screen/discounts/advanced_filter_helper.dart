import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester,
) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsKeys.advancedFilterMob)).isNotEmpty;

  await scrollingHelperInt(
    tester: tester,
    itemKey: isMobile
        ? DiscountsKeys.advancedFilterMob
        : DiscountsKeys.advancedFilterDesk,
  );

  expect(
    find.byKey(
      isMobile
          ? DiscountsKeys.advancedFilterMob
          : DiscountsKeys.advancedFilterDesk,
    ),
    findsOneWidget,
  );
  // final advancedButton = tester.widgetList(
  //   find.byKey(DiscountsKeys.advancedFilterButton),
  // );

  if (isMobile) {
    expect(
      find.byKey(DiscountsKeys.advancedFilterButton),
      findsOneWidget,
    );
    // if (advancedButton.isNotEmpty) {
    await tester.tap(find.byKey(DiscountsKeys.advancedFilterButton));

    await tester.pumpAndSettle();
    // }
    // if (find
    //     .byKey(DiscountsKeys.advancedFilterList)
    //     .evaluate()
    //     .isEmpty) {
    //   await tester
    //       .tap(find.byKey(DiscountsKeys.
    // advancedFilterButton));

    //   await tester.pumpAndSettle();
    // }
  }

  expect(
    find.byKey(DiscountsKeys.advancedFilterList),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterText),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsKeys.discountText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  // expect(
  //   find.byKey(DiscountsKeys.discountItems),
  //   findsWidgets,
  // );

  // expect(
  //   find.byKey(DiscountsKeys.citiesText),
  //   findsOneWidget,
  // );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
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
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsKeys.advancedFilterResetButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsKeys.advancedFilterResetButton));

  await tester.pumpAndSettle();

  if (isMobile) {
    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsKeys.advancedFilterMob,
    );

    expect(
      find.byKey(DiscountsKeys.advancedFilterMob),
      findsOneWidget,
    );
    // final advancedButton = tester.widgetList(
    //   find.byKey(DiscountsKeys.advancedFilterButton),
    // );

    expect(
      find.byKey(DiscountsKeys.advancedFilterButton),
      findsOneWidget,
    );

    // if (advancedButton.isNotEmpty) {
    await tester.tap(find.byKey(DiscountsKeys.advancedFilterButton));
  }

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsNothing,
  );

  // final isMobile = tester
  //     .widgetList(find.byKey(DiscountsKeys.
  // advancedFilterDialog))
  //     .isNotEmpty;

  if (find.byKey(DiscountsKeys.advancedFilterDialog).evaluate().isNotEmpty) {
    // expect(
    //   find.byKey(DiscountsKeys.cancelIcon),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(DiscountsKeys.advancedFilterDialog),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsKeys.advancedFilterMobAppliedButton),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(DiscountsKeys.advancedFilterMobAppliedButton),
    );

    await tester.pumpAndSettle();
  } else {
    // expect(
    //   find.byKey(DiscountsKeys.advancedFilterButtonIcon),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(DiscountsKeys.advancedFilterButton),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsKeys.advancedFilterList),
      findsOneWidget,
    );

    // await tester
    //     .tap(find.byKey(DiscountsKeys.advancedFilterButton));

    // await tester.pumpAndSettle();

    // expect(
    //   find.byKey(DiscountsKeys.advancedFilterList),
    //   findsNothing,
    // );

    // expect(
    //   find.byKey(DiscountsKeys.advancedFilterButtonIconUp),
    //   findsOneWidget,
    // );
  }
}
