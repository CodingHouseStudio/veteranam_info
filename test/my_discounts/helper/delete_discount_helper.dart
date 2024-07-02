import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> deleteDiscountHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.card),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.myDiscounts.card,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash),
        findsWidgets,
      );

      await tester
          .tap(find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash).first);

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.card),
        findsNothing,
      );
    },
  );
}
