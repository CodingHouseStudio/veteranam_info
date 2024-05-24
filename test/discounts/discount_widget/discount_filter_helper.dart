import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> discountFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.discounts.filter), findsOneWidget);
}
