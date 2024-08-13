import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> mobFeedbackOpenHelperkHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.bugButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.bugButton));

  await tester.pumpAndSettle();

  await test(tester);
}
