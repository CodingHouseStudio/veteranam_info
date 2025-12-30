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
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: NawbarKeys.widget,
      );
      if (find.byKey(InvestorsKeys.title).evaluate().isEmpty) {
        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown100,
        );
      }

      final matcher = Config.isWeb ? findsOneWidget : findsNothing;

      expect(find.byKey(InvestorsKeys.title), matcher);
      // expect(find.byKey(InvestorsKeys.point),
      // findsOneWidget);

      expect(
        find.byKey(InvestorsKeys.feedbackTitle),
        matcher,
      );

      if (Config.isWeb) {
        await scrollingHelper(
          tester: tester,
          itemKey: InvestorsKeys.feedbackTitle,
        );
      }

      expect(
        find.byKey(InvestorsKeys.feedbackSubtitle),
        matcher,
      );

      expect(
        find.byKey(InvestorsKeys.feedbackButton),
        matcher,
      );

      if (Config.isWeb) {
        await doubleButtonHelper(tester);
      }

      expect(
        find.byKey(InvestorsKeys.rightImages),
        matcher,
      );

      expect(
        find.byKey(InvestorsKeys.leftImages),
        matcher,
      );

      if (Config.isWeb) {
        await scrollingHelper(
          tester: tester,
          itemKey: InvestorsKeys.leftImages,
        );
      }

      // else {
      //   expect(
      //     find.byKey(NawbarKeys.pageName),
      //     findsOneWidget,
      //   );
      // }

      expect(
        find.byKey(InvestorsKeys.fundsTitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: InvestorsKeys.fundsTitle,
      );

      expect(
        find.byKey(InvestorsKeys.fundsTitle),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(InvestorsKeys.buttonMock),
      //   findsNothing,
      // );

      expect(
        find.byKey(InvestorsKeys.card),
        findsWidgets,
      );

      // await reportDialogInitialHelper(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // expect(
      //   find.byKey(InvestorsKeys.button),
      //   findsWidgets,
      // );
      if (find.byKey(DonateCardKeys.subtitle).evaluate().isNotEmpty) {
        await donateCardHelper(tester: tester, isDesk: false);
      } else {
        await donatesCardHelper(tester);
      }
    },
  );
}
