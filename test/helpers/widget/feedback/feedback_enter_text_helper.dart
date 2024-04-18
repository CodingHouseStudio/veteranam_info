import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> feedbackEnterTextHelper({
  required WidgetTester tester,
  required String field,
  required String email,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonSave),
    findsOneWidget,
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

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.fieldMessage,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    field,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedback.buttonSave,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.feedback.buttonSave));

  await tester.pumpAndSettle();
}
