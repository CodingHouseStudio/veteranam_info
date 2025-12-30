import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> confirmPublishDiscountDialogHelper(
  WidgetTester tester, {
  bool isDialogOpened = true,
}) async {
  final matcher = isDialogOpened ? findsOneWidget : findsNothing;

  expect(
    find.byKey(ConfirmPublishDiscountKeys.title),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.closeIcon),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.continueButton),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.description),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.dialog),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.sendButton),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.termsAndConditionsButton),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.termsAndConditionsSwitcher),
    matcher,
  );

  expect(
    find.byKey(ConfirmPublishDiscountKeys.termsAndConditionsText),
    matcher,
  );
}
