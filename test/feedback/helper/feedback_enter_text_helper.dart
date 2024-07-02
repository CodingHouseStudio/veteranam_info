import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> feedbackEnterTextHelper({
  required WidgetTester tester,
  required String field,
  required String email,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.feedback.nameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.nameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.feedback.nameField),
    field,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.emailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.emailField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.feedback.emailField),
    email,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.messageField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.messageField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.feedback.messageField),
    field,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.feedback.button));

  await tester.pumpAndSettle();
}
