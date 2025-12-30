import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> feedbackEnterTextHelper({
  required WidgetTester tester,
  required String field,
  required String name,
  required String email,
}) async {
  expect(
    find.byKey(FeedbackKeys.nameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.nameField,
  );

  await tester.enterText(
    find.byKey(FeedbackKeys.nameField),
    name,
  );

  expect(
    find.byKey(FeedbackKeys.emailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.emailField,
  );

  await tester.enterText(
    find.byKey(FeedbackKeys.emailField),
    email,
  );

  expect(
    find.byKey(FeedbackKeys.messageField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.messageField,
  );

  await tester.enterText(
    find.byKey(FeedbackKeys.messageField),
    field,
  );

  expect(
    find.byKey(FeedbackKeys.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.button,
  );

  await tester.tap(find.byKey(FeedbackKeys.button));

  await tester.pumpAndSettle();
}
