import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/constants/constants.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
