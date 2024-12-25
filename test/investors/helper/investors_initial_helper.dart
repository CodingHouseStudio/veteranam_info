import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';
import 'helper.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      final matcher = Config.isWeb ? findsOneWidget : findsNothing;

      expect(find.byKey(KWidgetkeys.screen.investors.title), matcher);
      // expect(find.byKey(KWidgetkeys.screen.investors.point),
      // findsOneWidget);

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackTitle),
        matcher,
      );

      if (Config.isWeb) {
        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.investors.feedbackTitle,
        );
      }

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackSubtitle),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackButton),
        matcher,
      );

      if (Config.isWeb) {
        await doubleButtonHelper(tester);
      }

      expect(
        find.byKey(KWidgetkeys.screen.investors.rightImages),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.leftImages),
        matcher,
      );

      if (Config.isWeb) {
        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.investors.leftImages,
        );
      }

      // else {
      //   expect(
      //     find.byKey(KWidgetkeys.widget.nawbar.pageName),
      //     findsOneWidget,
      //   );
      // }

      expect(
        find.byKey(KWidgetkeys.screen.investors.fundsTitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.fundsTitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.fundsTitle),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.investors.buttonMock),
      //   findsNothing,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.investors.card),
        findsWidgets,
      );

      // await reportDialogInitialHelper(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.investors.button),
      //   findsWidgets,
      // );
      if (find
          .byKey(KWidgetkeys.widget.donateCard.subtitle)
          .evaluate()
          .isNotEmpty) {
        await donateCardHelper(tester: tester, isDesk: false);
      } else {
        await donatesCardHelper(tester);
      }
    },
  );
}
