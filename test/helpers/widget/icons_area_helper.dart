import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> iconsAreaHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.iconsAreKeys.plus), findsOneWidget);

  expect(find.byKey(KWidgetkeys.iconsAreKeys.person), findsOneWidget);
}
