import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/shared_flutter.dart';
import '../../../test_dependency.dart';

Future<void> advancedFilterSearchFieldHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(DiscountsFilterKeys.citySearchField), findsOneWidget);

  expect(
    find.byKey(DiscountsFilterKeys.citySearchFieldCloseIcon),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.citySearchField));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsFilterKeys.citySearchFieldCloseIcon),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(DiscountsFilterKeys.citySearchField),
    KTestVariables.field,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  expect(find.byKey(DiscountsFilterKeys.cityItems), findsNothing);

  await tester.tap(find.byKey(DiscountsFilterKeys.citySearchFieldCloseIcon));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    scrollKey: DiscountsFilterKeys.list,
    itemKey: DiscountsFilterKeys.citySearchField,
  );

  expect(
    find.byKey(DiscountsFilterKeys.citySearchFieldCloseIcon),
    findsNothing,
  );
}
