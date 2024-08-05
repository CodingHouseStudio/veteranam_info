import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> chipHelper(WidgetTester tester) async {
  expect(find.byKey(KWidgetkeys.widget.chip.widget), findsWidgets);

  late var filterChip = tester
      .widget<FilterChip>(find.byKey(KWidgetkeys.widget.chip.widget).last);

  expect(filterChip.selected, isFalse);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.chip.widget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.chip.widget).last,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  filterChip = tester
      .widget<FilterChip>(find.byKey(KWidgetkeys.widget.chip.widget).last);

  expect(filterChip.selected, isTrue);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.chip.widget).last,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  filterChip = tester
      .widget<FilterChip>(find.byKey(KWidgetkeys.widget.chip.widget).last);

  expect(filterChip.selected, isFalse);

  // await filterPopupMenuHelper(tester);

  // filterChip = tester
  //     .widget<FilterChip>(find.byKey(KWidgetkeys.widget.chip.widget).last);

  // expect(filterChip.selected, isFalse);
}
