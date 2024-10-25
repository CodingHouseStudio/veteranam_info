import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

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
        find.byKey(KWidgetkeys.widget.confirmPublishDiscount.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.confirmPublishDiscount.closeIcon),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        scrollKey: KWidgetkeys.widget.dialogs.scroll,
        itemKey: KWidgetkeys.widget.confirmPublishDiscount.closeIcon,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.confirmPublishDiscount.closeIcon),
      );

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.pop(),
      ).called(1);

      expect(
        find.byKey(KWidgetkeys.widget.confirmPublishDiscount.description),
        findsOneWidget,
      );

      expect(
        find.byKey(
          KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsSwitcher,
        ),
        findsOneWidget,
      );

      expect(
        find.byKey(
          KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsText,
        ),
        findsOneWidget,
      );

      expect(
        find.byKey(
          KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsButton,
        ),
        findsOneWidget,
      );
    },
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.dialogs.scroll,
    itemKey: KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsButton,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsButton,
    ),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.termsAndConditions.name),
  ).called(1);

  expect(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.continueButton,
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.continueButton,
    ),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.pop(),
  ).called(1);

  expect(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.sendButton,
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.sendButton,
    ),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.dialogs.scroll,
    itemKey:
        KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsSwitcher,
  );

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.dialogs.scroll,
    offset: KTestConstants.scrollingUp150,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.termsAndConditionsText,
    ),
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.widget.dialogs.scroll,
    itemKey: KWidgetkeys.widget.confirmPublishDiscount.sendButton,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.confirmPublishDiscount.sendButton,
    ),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();
}
