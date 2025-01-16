import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> deleteDiscountHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(MyDiscountsKeys.card),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: MyDiscountsKeys.card,
      );

      expect(
        find.byKey(MyDiscountsKeys.iconTrash),
        findsWidgets,
      );

      await tester.tap(
        find.byKey(MyDiscountsKeys.iconTrash).first,
        warnIfMissed: false,
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(MyDiscountsKeys.card),
        findsWidgets,
      );
    },
  );
}
