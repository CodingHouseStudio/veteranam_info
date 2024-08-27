import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobFeedbackOpenHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.feedbackButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.bugButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.bugButton));

  await tester.pumpAndSettle();

  await test(tester);
}
