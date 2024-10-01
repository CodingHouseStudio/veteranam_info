import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.card),
        findsWidgets,
      );

      await discountCardHelper(tester);

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

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.deactivate),
        findsWidgets,
      );
    },
  );
}
