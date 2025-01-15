import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmPublishDiscountDialogNavHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    scrollUp: false,
    windowsTest: true,
    size: KTestConstants.windowSmallSize,
    test: () async {
      expect(
        find.byKey(ConfirmPublishDiscountKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(ConfirmPublishDiscountKeys.closeIcon),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        scrollKey: DialogsKeys.scroll,
        itemKey: ConfirmPublishDiscountKeys.closeIcon,
      );

      await tester.tap(
        find.byKey(ConfirmPublishDiscountKeys.closeIcon),
      );

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.pop(),
      ).called(1);

      expect(
        find.byKey(ConfirmPublishDiscountKeys.description),
        findsOneWidget,
      );

      expect(
        find.byKey(
          ConfirmPublishDiscountKeys.termsAndConditionsSwitcher,
        ),
        findsOneWidget,
      );

      expect(
        find.byKey(
          ConfirmPublishDiscountKeys.termsAndConditionsText,
        ),
        findsOneWidget,
      );

      expect(
        find.byKey(
          ConfirmPublishDiscountKeys.termsAndConditionsButton,
        ),
        findsOneWidget,
      );
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

  verify(
    () => mockGoRouter.pop(),
  ).called(1);

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
}
