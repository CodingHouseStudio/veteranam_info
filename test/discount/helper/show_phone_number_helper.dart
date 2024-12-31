import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountShowPhoneNumberHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discount.phoneNumberHideButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discount.phoneNumberHideButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.screen.discount.phoneNumberHideButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discount.phoneNumberHideButton),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discount.phoneNumberButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discount.phoneNumberButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discount.phoneNumberButton),
    findsOneWidget,
  );
}
