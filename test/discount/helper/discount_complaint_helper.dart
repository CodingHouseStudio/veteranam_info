import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountComplaintHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(DiscountKeys.complaintButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountKeys.complaintButton,
  );

  await tester.tap(find.byKey(DiscountKeys.complaintButton));

  await tester.pumpAndSettle();

  await reportDialogHelper(tester);
}
