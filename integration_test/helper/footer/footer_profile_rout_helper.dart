import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerProfileRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.profileButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.profileButton));

  await tester.pumpAndSettle();
}
