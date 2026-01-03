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
    find.byKey(MyDiscountsKeys.iconTrash),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MyDiscountsKeys.iconTrash,
  );

  await tester.tap(find.byKey(MyDiscountsKeys.iconTrash).first);

  await tester.pumpAndSettle();

  await confirmDialogChangesHelper(
    tester: tester,
    hasTimer: true,
  );
}
