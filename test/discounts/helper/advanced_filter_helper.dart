import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

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
    tapItemLast: true,
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

  await tester
      .tap(find.byKey(KWidgetkeys.screen.discounts.advancedFilterResetButton));

  await tester.pumpAndSettle();

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
