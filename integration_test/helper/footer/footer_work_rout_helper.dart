import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerWorkRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.workButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.workButton));

  await tester.pumpAndSettle();
}
