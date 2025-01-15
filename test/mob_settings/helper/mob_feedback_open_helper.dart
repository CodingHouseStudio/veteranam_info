import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> mobFeedbackOpenHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.feedbackButton,
  );

  expect(
    find.byKey(MobSettingsKeys.bugButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobSettingsKeys.bugButton));

  await tester.pumpAndSettle();

  await test(tester);
}
