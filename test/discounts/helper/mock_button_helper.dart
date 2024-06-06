import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> mockButtonHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.discounts.card),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discounts.buttonMock),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discounts.buttonMock));
}
