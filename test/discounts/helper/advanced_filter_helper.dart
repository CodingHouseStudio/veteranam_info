import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester,
) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsKeys.advancedFilterMob)).isNotEmpty;

  await scrollingHelper(
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
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterText),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsNothing,
  );

  // expect(
  //   find.byKey(DiscountsKeys.discountText),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(DiscountsKeys.discountItems),
  //   findsWidgets,
  // );

  // expect(
  //   find.byKey(DiscountsKeys.citiesText),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(DiscountsKeys.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsKeys.advancedFilterList,
  );

  // expect(
  //   find.byKey(DiscountsKeys.appliedFilterText),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
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
    find.byKey(DiscountsKeys.appliedFilterItems).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DiscountsKeys.appliedFilterItems).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  // await tester.tap(
  //   find.byKey(DiscountsKeys.appliedFilterItems).last,
  //   warnIfMissed: false,
  // );

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
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsKeys.advancedFilterResetButton),
    findsOneWidget,
  );

  if (isMobile) {
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
  } else {
    await tester.tap(
      find.byKey(DiscountsKeys.advancedFilterResetButton),
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(DiscountsKeys.appliedFilterItems),
      findsNothing,
    );

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
