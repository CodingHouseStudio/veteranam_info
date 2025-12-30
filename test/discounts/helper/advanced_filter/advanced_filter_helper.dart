import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester, {
  bool reset = true,
}) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsFilterKeys.mob)).isNotEmpty;

  await scrollingHelper(
    tester: tester,
    itemKey: isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
  );

  expect(
    find.byKey(
      isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
    ),
    findsOneWidget,
  );

  if (isMobile) {
    expect(
      find.byKey(DiscountsFilterKeys.mobButton),
      findsOneWidget,
    );

    await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

    await tester.pumpAndSettle();
  }

  expect(
    find.byKey(DiscountsFilterKeys.list),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.appliedText),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.eligibilitiesItems,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesText),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.categoriesText,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsNothing,
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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  if (isMobile) {
    // expect(
    //   find.byKey(DiscountsFilterKeys.cancelIcon),
    //  findsOneWidget,
    // );

    expect(
      find.byKey(DiscountsFilterKeys.dialog),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsFilterKeys.mobAppliedButton),
      findsOneWidget,
    );
  }

  if (reset) {
    await tester.tap(
      find.byKey(DiscountsFilterKeys.resetButton),
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();
  }
}
