import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> dropChipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dropChip.widget).first, findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.dropChip.button), findsNothing);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropChip.widget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropChip.widget).first,
  );
  await tester.pumpAndSettle();

  final dropChip = tester.widget<DropdownButton<dynamic>>(
    find.byKey(KWidgetkeys.widget.dropChip.widget).first,
  );

  if (dropChip.items == null || dropChip.items!.isEmpty) return;

  expect(
    find.byKey(KWidgetkeys.widget.dropChip.button).first,
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropChip.button,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropChip.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropChip.button).first,
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropChip.widget).first,
      matching: find.text(dropChip.items!.last.value.toString()),
    ),
    findsOneWidget,
  );

  await filterPopupMenuHelper(tester);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropChip.widget).first,
      matching: find.text(dropChip.items!.first.value.toString()),
    ),
    findsNothing,
  );
}
