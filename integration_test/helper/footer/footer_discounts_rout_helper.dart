import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerDiscountsRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.discountsButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.discountsButton));

  await tester.pumpAndSettle();
}
