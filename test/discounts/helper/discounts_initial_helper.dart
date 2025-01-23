import 'package:flutter_test/flutter_test.dart';
// import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

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
      // if (!Config.isWeb) {
      //   expect(
      //     find.byKey(NawbarKeys.pageName),
      //     findsOneWidget,
      //   );
      //   //   expect(
      //   //     find.byKey(DiscountsKeys.titlePoint),
      //   //     findsOneWidget,
      //   //   );
      //   // } else {
      //   await mobNavigationHelper(tester);
      // } else {
      expect(
        find.byKey(DiscountsKeys.title),
        findsOneWidget,
      );
      // }

      expect(
        find.byKey(DiscountsKeys.sortingButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: DiscountsKeys.sortingButton,
      );

      await popupMenyButtonTapHelper(
        tester: tester,
        buttonListKeys: DiscountsKeys.sortingList,
        buttonKey: DiscountsKeys.sortingButton,
      );

      await discountsViewModeHelper(tester);

      // await filterChipHelper(tester);

      // if (Config.isBusiness) {
      //   expect(
      //     find.byKey(DiscountsKeys.addDiscountButton),
      //     findsOneWidget,
      //   );
      // }

      await scrollingHelper(
        tester: tester,
        itemKey: DiscountsKeys.title,
      );

      expect(
        find.byKey(DiscountsKeys.card),
        findsWidgets,
      );

      await discountCardHelper(tester: tester);

      await scrollingHelper(
        tester: tester,
        itemKey: DiscountsKeys.card,
      );

      // expect(
      //   find.byKey(DiscountsKeys.buttonMock),
      //   findsNothing,
      // );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp500,
      // );

      // expect(
      //   find.byKey(DiscountsKeys.button),
      //   findsOneWidget,
      // );
    },
  );

  // expect(
  //   find.byKey(DiscountsKeys.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(DiscountsKeys.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}
