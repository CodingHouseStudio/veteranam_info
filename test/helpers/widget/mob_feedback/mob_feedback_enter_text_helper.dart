import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackEnterTextHelper({
  required WidgetTester tester,
  required String message,
  required String email,
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
    find.byKey(MobFeedbackKeys.messageField),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(MobFeedbackKeys.messageField),
    message,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(MobFeedbackKeys.emailField),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(MobFeedbackKeys.emailField),
    email,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(tester: tester, itemKey: MobFeedbackKeys.emailField);

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
