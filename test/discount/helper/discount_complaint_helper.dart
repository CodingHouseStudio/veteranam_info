import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountComplaintHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.discount.complaintButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discount.complaintButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discount.complaintButton));

  await tester.pumpAndSettle();

  await reportDialogHelper(tester);
}
