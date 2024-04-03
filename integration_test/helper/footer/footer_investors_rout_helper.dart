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
    itemKey: KWidgetkeys.widget.footer.investorsButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.investorsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.investorsButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.investors.screen),
    findsOneWidget,
  );
}
