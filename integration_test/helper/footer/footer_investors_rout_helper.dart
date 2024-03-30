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
    item: find.byKey(KWidgetkeys.footerKeys.investorsButton),
  );

  expect(find.byKey(KWidgetkeys.footerKeys.investorsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.investorsButton));

  await tester.pumpAndSettle();
}
