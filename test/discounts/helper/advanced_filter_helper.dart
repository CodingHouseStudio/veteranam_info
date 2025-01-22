import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester, {
  bool isOpened = true,
}) async {
  final matcher = isOpened ? findsOneWidget : findsNothing;
  final matchers = isOpened ? findsWidgets : findsNothing;
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
    matcher,
  );

  if (isMobile) {
    expect(
      find.byKey(DiscountsFilterKeys.mobButton),
      matcher,
    );

    await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

    await tester.pumpAndSettle();
  }

  expect(
    find.byKey(DiscountsFilterKeys.list),
    matcher,
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
    matcher,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    matchers,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.eligibilitiesItems,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesText),
    matcher,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.categoriesText,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    matchers,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citiesText),
    matcher,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    matchers,
  );

  await chekPointHelper(hasAmount: true, tester: tester);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    matcher,
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

  await chekPointSignleTapHelper(
    tester: tester,
    index: 2,
    hasAmount: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    index: 1,
    hasAmount: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(
    find.byKey(DiscountsFilterKeys.cancelChip).first,
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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    matchers,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  if (isMobile) {
    // expect(
    //   find.byKey(DiscountsFilterKeys.cancelIcon),
    //  matcher,
    // );

    expect(
      find.byKey(DiscountsFilterKeys.dialog),
      matcher,
    );

    expect(
      find.byKey(DiscountsFilterKeys.mobAppliedButton),
      matcher,
    );
  }

  await tester.tap(
    find.byKey(DiscountsFilterKeys.resetButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();
}
