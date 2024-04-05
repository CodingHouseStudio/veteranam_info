import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> dropChipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.dropChip.widget), findsWidgets);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropChip.widget).first,
  );
  await tester.pumpAndSettle();

  final dropChip = tester.widget<DropdownButton<dynamic>>(
    find.byKey(KWidgetkeys.widget.dropChip.widget).first,
  );

  if (dropChip.items == null || dropChip.items!.isEmpty) return;

  expect(
    find.byKey(KWidgetkeys.widget.dropChip.button),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropChip.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropChip.button),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropChip.widget),
      matching: find.text(dropChip.items!.last.value.toString()),
    ),
    findsNothing,
  );

  await filterPopupMenuHelper(tester);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.dropChip.widget),
      matching: find.text(dropChip.items!.first.value.toString()),
    ),
    findsNothing,
  );
}
