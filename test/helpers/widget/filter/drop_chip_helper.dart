import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> dropChipHelper({
  required WidgetTester tester,
  required Key dropChipKey,
  required Key buttonKey,
}) async {
  expect(find.byKey(dropChipKey), findsWidgets);

  expect(find.byKey(buttonKey), findsWidgets);

  await scrollingHelper(
    tester: tester,
    itemKey: dropChipKey,
  );

  await tester.tap(
    find.byKey(dropChipKey),
  );
  await tester.pumpAndSettle();

  final dropChip = tester.widget<DropdownButton<dynamic>>(
    find.byKey(dropChipKey).first,
  );

  if (dropChip.items == null || dropChip.items!.isEmpty) return;

  expect(
    find.byKey(buttonKey),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: buttonKey,
  );

  await tester.tap(
    find.byKey(buttonKey).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(buttonKey),
    findsWidgets,
  );

  expect(
    find.descendant(
      of: find.byKey(dropChipKey).first,
      matching: find.text(dropChip.items!.first.value.toString()),
    ),
    findsOneWidget,
  );

  await filterPopupMenuHelper(tester);

  expect(
    find.descendant(
      of: find.byKey(dropChipKey).first,
      matching: find.text(dropChip.items!.first.value.toString()),
    ),
    findsNothing,
  );
}
