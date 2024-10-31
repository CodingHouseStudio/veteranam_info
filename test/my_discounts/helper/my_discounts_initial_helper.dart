import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconAdd),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.myDiscounts.subtitle),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.card),
        findsWidgets,
      );

      await discountCardHelper(
        tester: tester,
        containComplaintIcon: false,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.status),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.myDiscounts.status,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.myDiscounts.iconTrash,
      );

      // await tester
      //     .tap(find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash).first);

      // await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.myDiscounts.deactivate,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.deactivate),
        findsWidgets,
      );

      await tester
          .tap(find.byKey(KWidgetkeys.screen.myDiscounts.deactivate).first);

      await tester.pumpAndSettle();

      await tester
          .tap(find.byKey(KWidgetkeys.screen.myDiscounts.deactivate).first);

      await tester.pumpAndSettle();

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);
    },
  );
}
