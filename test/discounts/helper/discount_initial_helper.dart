import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> discountInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.discounts.filter),
    findsOneWidget,
  );

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

  expect(
    find.byKey(KWidgetkeys.screen.discounts.button),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
    findsNothing,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.discounts.filter),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.card),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.buttonMock),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discounts.buttonIcon),
        findsOneWidget,
      );
    },
  );
}
