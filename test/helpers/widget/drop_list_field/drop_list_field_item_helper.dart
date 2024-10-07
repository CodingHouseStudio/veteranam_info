import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dropListFieldItemHelper({
  required WidgetTester tester,
  required Key textFieldKey,
  String? Function()? itemTextWidget,
  int fieldIndex = 0,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.dropListField.widget),
    findsWidgets,
  );

  expect(
    find.byKey(textFieldKey),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.list),
  //   findsNothing,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.icon),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon),
    findsNothing,
  );

  // expect(
  //   find.descendant(
  //     of: find.byKey(KWidgetkeys.widget.dropListField.list),
  //     matching: find.byKey(KWidgetkeys.widget.dropListField.item),
  //   ),
  //   findsNothing,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropListField.widget,
  );

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsWidgets,
  );

  if (itemTextWidget == null) {
    expect(
      find.byKey(KWidgetkeys.widget.dropListField.itemText),
      findsWidgets,
    );
  }

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.item),
  //   findsWidgets,
  // );

  final text = itemTextWidget?.call() ??
      tester
          .widget<Text>(
            find.byKey(KWidgetkeys.widget.dropListField.itemText).first,
          )
          .data;

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.item).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.item),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.list),
    findsNothing,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(text ?? ''),
    ),
    findsOneWidget,
  );
}
