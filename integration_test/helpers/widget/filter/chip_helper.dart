import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chipHelper(WidgetTester tester) async {
  final isDesk = find.byKey(ChipKeys.desk).evaluate().isNotEmpty;
  final widgetKey = isDesk ? ChipKeys.desk : ChipKeys.mob;

  expect(
    find.byKey(ChipKeys.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(ChipKeys.mob),
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
    find.byKey(ChipKeys.text),
    findsWidgets,
  );

  expect(
    find.byKey(ChipKeys.amount),
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
        find.byKey(ChipKeys.text).at(i),
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
