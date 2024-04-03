import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helper.dart';

Future<void> footerInvestorsRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widgetKeys.footerKeys.investorsButton,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.investorsButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widgetKeys.footerKeys.investorsButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screenKeys.investorsScreenKeys.screen),
    findsOneWidget,
  );
}
