import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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

  await scrollingHelperInt(
    tester: tester,
    itemKey: widgetKey,
  );

  late var filterChip = tester.widget<FilterChip>(find.byKey(widgetKey).at(1));

  expect(filterChip.selected, isFalse);

  await scrollingHelperInt(
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
      final widgetLocation = tester.getCenter(
        find.byKey(KWidgetkeys.widget.chip.text).at(i),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);

      await gesture.addPointer(location: widgetLocation);

      await tester.pumpAndSettle();

      await gesture.removePointer(location: widgetLocation);

      await tester.pumpAndSettle();
    }
  }

  // await filterPopupMenuHelper(tester);

  // filterChip = tester
  //     .widget<FilterChip>(find.byKey(widgetKey).at(1));

  // expect(filterChip.selected, isFalse);
}
