import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> advancedFilterCloseOpenItemsHelper(
  WidgetTester tester,
) async {
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

  await tester.tap(find.byKey(DiscountsFilterKeys.categoriesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.categoriesItems), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citiesText,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.cityItems), findsNothing);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  for (var i = 0; i < 3; i++) {
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

  await tester.tap(find.byKey(DiscountsFilterKeys.citiesText));

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.cityItems), findsWidgets);

  await advancedFilterSearchFieldHelper(tester);

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
