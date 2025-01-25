import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> advancedFilterAppliedHelper(
  WidgetTester tester,
) async {
  await advancedFilterHelper(
    tester,
    reset: false,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsFilterKeys.mobAppliedButton,
  );

  await tester.tap(
    find.byKey(DiscountsFilterKeys.mobAppliedButton),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(DiscountsFilterKeys.list), findsNothing);
}
