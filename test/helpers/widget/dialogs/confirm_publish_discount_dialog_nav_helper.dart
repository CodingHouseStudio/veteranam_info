import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmPublishDiscountDialogNavHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required Future<void> Function() openEvent,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    scrollUp: false,
    windowsTest: true,
    size: KTestConstants.windowSmallSize,
    test: () async {
      await confirmPublishDiscountDialogHelper(tester);

      await scrollingHelper(
        tester: tester,
        scrollKey: DialogsKeys.scroll,
        itemKey: ConfirmPublishDiscountKeys.closeIcon,
      );

      await tester.tap(
        find.byKey(ConfirmPublishDiscountKeys.closeIcon),
      );

      await tester.pumpAndSettle();

      await confirmPublishDiscountDialogHelper(
        tester,
        isDialogOpened: false,
      );

      await openEvent();
    },
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: DialogsKeys.scroll,
    itemKey: ConfirmPublishDiscountKeys.termsAndConditionsButton,
  );

  await tester.tap(
    find.byKey(
      ConfirmPublishDiscountKeys.termsAndConditionsButton,
    ),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.termsAndConditions.name),
  ).called(1);

  expect(
    find.byKey(
      ConfirmPublishDiscountKeys.continueButton,
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      ConfirmPublishDiscountKeys.continueButton,
    ),
  );

  await tester.pumpAndSettle();

  await confirmPublishDiscountDialogHelper(
    tester,
    isDialogOpened: false,
  );

  await openEvent();

  expect(
    find.byKey(
      ConfirmPublishDiscountKeys.sendButton,
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      ConfirmPublishDiscountKeys.sendButton,
    ),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    scrollKey: DialogsKeys.scroll,
    itemKey: ConfirmPublishDiscountKeys.termsAndConditionsSwitcher,
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: DialogsKeys.scroll,
    offset: KTestConstants.scrollingUp150,
  );

  await tester.tap(
    find.byKey(
      ConfirmPublishDiscountKeys.termsAndConditionsText,
    ),
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    scrollKey: DialogsKeys.scroll,
    itemKey: ConfirmPublishDiscountKeys.sendButton,
  );

  await tester.tap(
    find.byKey(
      ConfirmPublishDiscountKeys.sendButton,
    ),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await confirmPublishDiscountDialogHelper(
    tester,
    isDialogOpened: false,
  );
}
