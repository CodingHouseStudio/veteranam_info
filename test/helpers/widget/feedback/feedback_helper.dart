import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> feedbackHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonSave),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.email),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldName),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.message),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.name),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonClear),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.saveMessage),
    findsNothing,
  );

  await messageFieldHelper(tester: tester, message: KTestText.field);
}
