import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> dropListFieldBoxHelper({
  required WidgetTester tester,
  required String text,
  required Key fieldKey,
}) async {
  expect(
    find.byKey(DropListFieldKeys.widget),
    findsOneWidget,
  );

  expect(
    fieldKey,
    findsOneWidget,
  );

  // expect(
  //   find.byKey(DropListFieldKeys.list),
  //   findsNothing,
  // );

  expect(
    find.byType(DropdownMenuEntry<String>),
    findsNothing,
  );

  expect(
    find.byKey(DropListFieldKeys.icon),
    findsOneWidget,
  );

  expect(
    find.byKey(DropListFieldKeys.activeIcon),
    findsNothing,
  );

  // expect(
  //   find.descendant(
  //     of: find.byKey(DropListFieldKeys.list),
  //     matching: find.byKey(DropListFieldKeys.item),
  //   ),
  //   findsNothing,
  // );

  expect(
    find.byType(DropdownMenuEntry<String>),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: fieldKey,
  );

  await tester.tap(
    find.byKey(fieldKey),
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(DropListFieldKeys.list),
  //   findsOneWidget,
  // );

  expect(
    find.byType(DropdownMenuEntry<String>),
    findsWidgets,
  );

  expect(
    find.byKey(DropListFieldKeys.activeIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(DropListFieldKeys.icon),
    findsNothing,
  );

  // expect(
  //   find.byKey(DropListFieldKeys.item),
  //   findsWidgets,
  // );

  final textWidget = tester.widget<Text>(
    find.byType(DropdownMenuEntry<String>).first,
  );

  await tester.tap(
    find.byType(DropdownMenuEntry<String>).first,
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(DropListFieldKeys.list),
  //   findsNothing,
  // );

  expect(
    find.byType(DropdownMenuEntry<String>),
    findsNothing,
  );

  if (textWidget.data != null) return;
  expect(
    find.descendant(
      of: find.byKey(DropListFieldKeys.widget),
      matching: find.text(textWidget.data!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(fieldKey),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(fieldKey),
    text,
  );
  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(DropListFieldKeys.widget),
      matching: find.text(text),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(fieldKey),
    '${textWidget.data}$text',
  );

  await tester.pumpAndSettle();

  expect(
    find.byType(DropdownMenuEntry<String>),
    findsNothing,
  );
  // expect(
  //   find.byKey(DropListFieldKeys.item),
  //   findsNothing,
  // );
}
