import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> dropListFieldBoxHelper({
  required WidgetTester tester,
  required String text,
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
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.trailing),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.trailingUp),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.list),
      matching: find.byKey(KWidgetkeys.widget.dropListField.item).first,
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
    find.byKey(KWidgetkeys.widget.dropListField.trailingUp),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.trailing),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item).first,
    findsOneWidget,
  );

  final textWidget = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.dropListField.itemText).first,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.itemText).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsNothing,
  );

  if (textWidget.data != null) return;
  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(textWidget.data!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    text,
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(text),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    '${textWidget.data}$text',
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item).first,
    findsNothing,
  );
}
