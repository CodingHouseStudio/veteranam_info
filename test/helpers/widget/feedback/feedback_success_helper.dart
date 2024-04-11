import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> feedbackSuccessHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonSave),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.email),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldEmail),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldName),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.fieldMessage),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.message),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.name),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.subtitle),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.title),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.buttonClear),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.feedback.saveMessage),
    findsOneWidget,
  );
}
