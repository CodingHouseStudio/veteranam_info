import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../helpers/widget/statistic_box_helper.dart';
import '../../text_dependency.dart';

Future<void> myDiscountsInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.subtitle),
    findsOneWidget,
  );

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

  await statisticBoxHelper(tester: tester);

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.card),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconTrash),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconEdit),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconShare),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.diactivate),
        findsWidgets,
      );
      await statisticBoxHelper(tester: tester);
    },
  );
}
