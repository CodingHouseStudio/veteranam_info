import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(find.byKey(KWidgetkeys.screen.investors.title), findsOneWidget);

      expect(find.byKey(KWidgetkeys.screen.investors.point), findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackTitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.feedbackTitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackSubtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.rightImages),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.leftImages),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.leftImages,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.fundsPoint),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.fundsPoint,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.fundsTitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.buttonMock),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.card),
        findsWidgets,
      );

      // await reportDialogInitialHelper(tester);

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingDown,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.screen.investors.button),
      //   findsWidgets,
      // );
    },
  );

  await donateCardHelper(tester: tester, isDesk: false);

  await donatesCardHelper(tester);
}
