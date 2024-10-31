import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chipHelper(WidgetTester tester) async {
  final isDesk = find.byKey(KWidgetkeys.widget.chip.desk).evaluate().isNotEmpty;
  final widgetKey =
      isDesk ? KWidgetkeys.widget.chip.desk : KWidgetkeys.widget.chip.mob;

  expect(
    find.byKey(KWidgetkeys.widget.chip.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.chip.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: widgetKey,
  );

  late var filterChip = tester.widget<FilterChip>(find.byKey(widgetKey).at(1));

  expect(filterChip.selected, isFalse);

  await scrollingHelper(
    tester: tester,
    itemKey: widgetKey,
    first: false,
  );

  expect(
    find.byKey(KWidgetkeys.widget.chip.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.chip.amount),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(widgetKey).at(1),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  filterChip = tester.widget<FilterChip>(find.byKey(widgetKey).at(1));

  expect(filterChip.selected, isTrue);

  await tester.tap(
    find.byKey(widgetKey).at(1),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  filterChip = tester.widget<FilterChip>(find.byKey(widgetKey).at(1));

  expect(filterChip.selected, isFalse);

  if (isDesk) {
    for (var i = 0; i < 1; i++) {
      await hoverHelper(
        tester: tester,
        key: KWidgetkeys.widget.chip.text,
        index: i,
      );
    }
  }

  // await filterPopupMenuHelper(tester);

  // filterChip = tester
  //     .widget<FilterChip>(find.byKey(widgetKey).at(1));

  // expect(filterChip.selected, isFalse);
}
