import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> advancedFilterHelper(
  WidgetTester tester,
) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsFilterKeys.mob)).isNotEmpty;

  await scrollingHelperInt(
    tester: tester,
    itemKey: isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
  );

  expect(
    find.byKey(
      isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
    ),
    findsOneWidget,
  );
  // final advancedButton = tester.widgetList(
  //   find.byKey(DiscountsFilterKeys.mobButton),
  // );

  if (isMobile) {
    expect(
      find.byKey(DiscountsFilterKeys.mobButton),
      findsOneWidget,
    );
    // if (advancedButton.isNotEmpty) {
    await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

    await tester.pumpAndSettle();
    // }
    // if (find
    //     .byKey(DiscountsFilterKeys.list)
    //     .evaluate()
    //     .isEmpty) {
    //   await tester
    //       .tap(find.byKey(DiscountsFilterKeys.
    // mobButton));

    //   await tester.pumpAndSettle();
    // }
  }

  expect(
    find.byKey(DiscountsFilterKeys.list),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.appliedText),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  // expect(
  //   find.byKey(DiscountsFilterKeys.discountItems),
  //   findsWidgets,
  // );

  // expect(
  //   find.byKey(DiscountsFilterKeys.citiesText),
  //   findsOneWidget,
  // );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsWidgets,
  );

  await chekPointHelper(hasAmount: true, tester: tester);

  await chekPointSignleTapHelper(tester: tester, hasAmount: true);

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.appliedText),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
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
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsFilterKeys.resetButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.resetButton));

  await tester.pumpAndSettle();

  if (isMobile) {
    await scrollingHelperInt(
      tester: tester,
      itemKey: DiscountsFilterKeys.mob,
    );

    expect(
      find.byKey(DiscountsFilterKeys.mob),
      findsOneWidget,
    );
    // final advancedButton = tester.widgetList(
    //   find.byKey(DiscountsFilterKeys.mobButton),
    // );

    expect(
      find.byKey(DiscountsFilterKeys.mobButton),
      findsOneWidget,
    );

    // if (advancedButton.isNotEmpty) {
    await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));
  }

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsNothing,
  );

  // final isMobile = tester
  //     .widgetList(find.byKey(DiscountsFilterKeys.
  // dialog))
  //     .isNotEmpty;

  if (find.byKey(DiscountsFilterKeys.dialog).evaluate().isNotEmpty) {
    // expect(
    //   find.byKey(DiscountsFilterKeys.cancelIcon),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(DiscountsFilterKeys.dialog),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsFilterKeys.mobAppliedButton),
      findsOneWidget,
    );

    await tester.tap(
      find.byKey(DiscountsFilterKeys.mobAppliedButton),
    );

    await tester.pumpAndSettle();
  } else {
    // expect(
    //   find.byKey(DiscountsFilterKeys.mobButtonIcon),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(DiscountsFilterKeys.mobButton),
      findsOneWidget,
    );

    expect(
      find.byKey(DiscountsFilterKeys.list),
      findsOneWidget,
    );

    // await tester
    //     .tap(find.byKey(DiscountsFilterKeys.mobButton));

    // await tester.pumpAndSettle();

    // expect(
    //   find.byKey(DiscountsFilterKeys.list),
    //   findsNothing,
    // );

    // expect(
    //   find.byKey(DiscountsFilterKeys.mobButtonIconUp),
    //   findsOneWidget,
    // );
  }
}
