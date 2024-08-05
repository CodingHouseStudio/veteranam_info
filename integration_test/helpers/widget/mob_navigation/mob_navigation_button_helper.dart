import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> mobNavigationButtonHelper({
  required WidgetTester tester,
  required Key buttonKey,
}) async {
  expect(
    find.byKey(buttonKey),
    findsOneWidget,
  );

  await tester.tap(find.byKey(buttonKey));

  await tester.pumpAndSettle();
}
