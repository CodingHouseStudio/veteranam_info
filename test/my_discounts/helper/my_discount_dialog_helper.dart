import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> myDiscountDialogHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.myDiscounts.iconTrash,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash).first);

  await tester.pumpAndSettle();

  await dialogConfirmChangesHelper(
    tester: tester,
    hasTimer: true,
  );
}
