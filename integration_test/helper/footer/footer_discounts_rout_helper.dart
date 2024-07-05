import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> footerDiscountsRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrolling,
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
