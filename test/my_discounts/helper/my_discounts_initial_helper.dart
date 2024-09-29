import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
    findsNothing,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async => expect(
      find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
      findsWidgets,
    ),
  );

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

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconShare),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.diactivate),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.myDiscounts.diactivate,
      );

      await statisticBoxHelper(tester: tester);
    },
  );
}
