import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackEnterTextHelper({
  required WidgetTester tester,
  required String text,
}) async {
  expect(
    find.byKey(MobFeedbackKeys.title),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(MobFeedbackKeys.title),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle(const Duration(seconds: 15));

  expect(
    find.byKey(MobFeedbackKeys.field),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(MobFeedbackKeys.field),
    text,
  );

  expect(
    find.byKey(MobFeedbackKeys.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MobFeedbackKeys.button,
  );

  await tester.tap(
    find.byKey(MobFeedbackKeys.button),
    // warnIfMissed: false,
  );

  await tester.pumpAndSettle(
    const Duration(
      seconds: 10,
    ),
  );
}
