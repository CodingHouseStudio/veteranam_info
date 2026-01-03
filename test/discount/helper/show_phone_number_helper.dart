import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountShowPhoneNumberHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: DiscountKeys.phoneNumberHideButton,
  );

  expect(
    find.byKey(DiscountKeys.phoneNumberHideButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountKeys.phoneNumberHideButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountKeys.phoneNumberHideButton),
    findsNothing,
  );

  expect(
    find.byKey(DiscountKeys.phoneNumberButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountKeys.phoneNumberButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountKeys.phoneNumberButton),
    findsOneWidget,
  );
}
