import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> advancedFilterCloseOpenItemsHelper(
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

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.eligibilitiesText,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.eligibilitiesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.eligibilitiesItems), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.categoriesText,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.categoriesText,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.categoriesItems), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  for (var i = 0; i < 2; i++) {
    await tester.tap(
      find.byKey(DiscountsFilterKeys.cancelChip).first,
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();
  }

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.categoriesItems), findsWidgets);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.eligibilitiesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.eligibilitiesItems), findsWidgets);
}

Future<void> advancedFilterCloseOpenCitiesItemsHelper(
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

  if (find.byKey(DiscountsFilterKeys.cityItems).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
      scrollKey: DiscountsFilterKeys.list,
    );
  }

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsWidgets,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
    last: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citiesText,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cityItems),
    findsWidgets,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.cityItems), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.appliedText,
  );

  await tester.tap(
    find.byKey(DiscountsFilterKeys.cancelChip).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citiesText,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  expect(find.byKey(DiscountsFilterKeys.cityItems), findsWidgets);

  await advancedFilterSearchFieldHelper(tester);
}
