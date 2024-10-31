import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> myDiscountFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.discounts.card),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}
