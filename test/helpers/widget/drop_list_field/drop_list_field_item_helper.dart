import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dropListFieldItemHelper({
  required WidgetTester tester,
  int itemIndex = 0,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.dropListField.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.list),
  //   findsNothing,
  // );

  expect(
    find.byType(MenuItemButton),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.trailing),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.closeIcon),
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
    find.byType(MenuItemButton),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropListField.widget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.closeIcon),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.list),
  //   findsOneWidget,
  // );

  expect(
    find.byType(MenuItemButton),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.closeIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropListField.trailing),
    findsNothing,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.item),
  //   findsWidgets,
  // );

  final buttonWidget = tester.widget<MenuItemButton>(
    find.byType(MenuItemButton).at(itemIndex),
  );

  await tester.tap(
    find.byType(MenuItemButton).at(itemIndex),
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.list),
  //   findsNothing,
  // );

  expect(
    find.byType(MenuItemButton),
    findsNothing,
  );

  if (buttonWidget.child == null || buttonWidget.child! is! Text) return;
  final textWidget = buttonWidget.child! as Text;
  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropListField.widget),
      matching: find.text(textWidget.data!),
    ),
    findsOneWidget,
  );
}
