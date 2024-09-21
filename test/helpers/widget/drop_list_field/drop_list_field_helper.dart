import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dropListFieldHelper({
  required WidgetTester tester,
  required String text,
}) async {
  await dropListFieldItemHelper(
    tester: tester,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.field),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.dropListField.widget),
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
    find.byKey(KWidgetkeys.widget.dropListField.widget),
    text,
  );

  await tester.pumpAndSettle();

  expect(
    find.byType(MenuItemButton),
    findsWidgets,
  );

  await tester.tap(
    find.byType(MenuItemButton).first,
  );

  await tester.pumpAndSettle();
  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.item),
  //   findsNothing,
  // );
}
