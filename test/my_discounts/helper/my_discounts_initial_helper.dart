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
        find.byKey(MyDiscountsKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(MyDiscountsKeys.iconAdd),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(MyDiscountsKeys.subtitle),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(MyDiscountsKeys.card),
        findsWidgets,
      );

      await discountCardHelper(
        tester: tester,
        containComplaintIcon: false,
      );

      expect(
        find.byKey(MyDiscountsKeys.status),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: MyDiscountsKeys.status,
      );

      expect(
        find.byKey(MyDiscountsKeys.iconTrash),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: MyDiscountsKeys.iconTrash,
      );

      // await tester
      //     .tap(find.byKey(MyDiscountsKeys.iconTrash).first);

      // await tester.pumpAndSettle();

      expect(
        find.byKey(MyDiscountsKeys.iconEdit),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: MyDiscountsKeys.deactivate,
      );

      expect(
        find.byKey(MyDiscountsKeys.deactivate),
        findsWidgets,
      );

      await tester.tap(find.byKey(MyDiscountsKeys.deactivate).first);

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(MyDiscountsKeys.deactivate).first);

      await tester.pumpAndSettle();

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);
    },
  );
}
