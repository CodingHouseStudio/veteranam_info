import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> feedbackHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingDown);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp1500,
    itemKey: KWidgetkeys.widget.feedback.email,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonSave),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonClear),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.message),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    findsOneWidget,
  );

  await messageFieldHelper(tester: tester, message: KTestText.field);

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.email),
    findsOneWidget,
  );

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp500);

  expect(
    find.byKey(KWidgetkeys.widget.feedback.name),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldName),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.subtitle),
    findsOneWidget,
  );

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp200);

  expect(
    find.byKey(KWidgetkeys.widget.feedback.title),
    findsOneWidget,
  );
}
