import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> advancedFilterEnchancedMobileHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: DiscountsKeys.title,
  );

  expect(
    find.byKey(
      DiscountsFilterKeys.mob,
    ),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.mobButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

  await tester.pumpAndSettle();

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

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.eligibilitiesText,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await chekPointSignleTapHelper(hasAmount: true, tester: tester);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesCancelChip),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await chekPointSignleTapHelper(hasAmount: true, tester: tester);

  expect(
    find.byKey(DiscountsFilterKeys.categoriesCancelChip),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesCancelChip));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.categoriesCancelChip),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.eligibilitiesCancelChip));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesCancelChip),
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
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.eligibilitiesText));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsNothing,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesText));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    findsNothing,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesText));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.categoriesItems),
    findsWidgets,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.eligibilitiesText));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.eligibilitiesItems),
    findsWidgets,
  );
}

Future<void> advancedFilterEnchancedMobileCityHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: DiscountsKeys.title,
  );

  expect(
    find.byKey(
      DiscountsFilterKeys.mob,
    ),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.mobButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.list),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsWidgets,
  );

  await chekPointSignleTapHelper(
    hasAmount: true,
    tester: tester,
    last: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citiesText),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.cityCancelChip,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.cityCancelChip));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citiesText),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCancelChip),
    findsNothing,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityOpenIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityCloseIcon),
    findsNothing,
  );

  // expect(
  //   find.byKey(DiscountsFilterKeys.cityItems),
  //   findsWidgets,
  // );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsNothing,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityOpenIcon),
    findsWidgets,
  );
}
