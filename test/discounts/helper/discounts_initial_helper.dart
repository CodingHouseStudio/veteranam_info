import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> discountsInitialHelper(
  WidgetTester tester,
) async {
  await discountsScrollHelper(
    tester: tester,
    test: notificationLinkHelper,
  );

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      if (!Config.isWeb) {
        expect(
          find.byKey(KWidgetkeys.widget.nawbar.pageName),
          findsOneWidget,
        );
        //   expect(
        //     find.byKey(KWidgetkeys.screen.discounts.titlePoint),
        //     findsOneWidget,
        //   );
        // } else {
        await mobNavigationHelper(tester);
      } else {
        expect(
          find.byKey(KWidgetkeys.screen.discounts.title),
          findsOneWidget,
        );
      }

      expect(
        find.byKey(KWidgetkeys.screen.discounts.filter),
        findsOneWidget,
      );

      await filterChipHelper(tester);

      if (Config.isBusiness) {
        expect(
          find.byKey(KWidgetkeys.screen.discounts.addDiscountButton),
          findsOneWidget,
        );
      }

      await advancedFilterHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.discounts.card),
        findsWidgets,
      );

      await discountCardHelper(tester);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.discounts.card,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.buttonMock),
        findsNothing,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp500,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.screen.discounts.button),
      //   findsOneWidget,
      // );
    },
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}
