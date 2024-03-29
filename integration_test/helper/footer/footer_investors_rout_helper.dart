import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerInvestorsRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.investorsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.investorsButton));

  await tester.pumpAndSettle();
}
