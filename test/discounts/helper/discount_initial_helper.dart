import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> discountInitialHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.discounts.filter),
        findsOneWidget,
      );

      await filterChipHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.discounts.card),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.discounts.card,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.buttonMock),
        findsNothing,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp500,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.button),
        findsOneWidget,
      );
    },
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
    findsNothing,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async => expect(
      find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
      findsOneWidget,
    ),
  );
}
