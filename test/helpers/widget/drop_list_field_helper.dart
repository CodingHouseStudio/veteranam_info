import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> dropListFieldBoxHelper({
  required WidgetTester tester,
  required String dropListitem,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.dropListField.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.items),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.list),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.items),
    findsWidgets,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.list),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.list),
      matching: find.text(dropListitem),
    ),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(dropListitem),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    dropListitem,
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(dropListitem),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    '${dropListitem}a',
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(dropListitem),
    ),
    findsNothing,
  );
}
