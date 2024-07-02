import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> footerInvestorsRoutHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrolling,
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
