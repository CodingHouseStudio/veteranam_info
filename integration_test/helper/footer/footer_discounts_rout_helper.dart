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
    itemKey: KWidgetkeys.widget.footer.discountsButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.discountsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.discountsButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discounts.screen),
    findsOneWidget,
  );
}
