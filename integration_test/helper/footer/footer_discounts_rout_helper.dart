import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerDiscountsRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.discountsButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.discountsButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.discountsButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.discountsScreenKeys.screen),
    findsOneWidget,
  );
}
