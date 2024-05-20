import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> feedbackClearTextHelper({
  required WidgetTester tester,
  required String field,
  required String email,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1000,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldName),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.fieldName,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.feedback.fieldName),
    field,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.fieldEmail,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
    email,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.fieldMessage,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    field,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonClear),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.buttonClear,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.feedback.buttonClear));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.feedback.fieldName),
      matching: find.text(field),
    ),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
      matching: find.text(field),
    ),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
      matching: find.text(email),
    ),
    findsNothing,
  );
}
