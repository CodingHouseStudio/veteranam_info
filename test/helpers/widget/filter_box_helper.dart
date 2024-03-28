import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> filterBoxHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.filterKeys.chips), findsOneWidget);

  expect(find.byKey(KWidgetkeys.filterKeys.popupMenu), findsOneWidget);

  await tester.tap(
    find.byKey(KWidgetkeys.filterKeys.lastChip),
  );
  await tester.pumpAndSettle();

  late var filterChip =
      tester.widget<FilterChip>(find.byKey(KWidgetkeys.filterKeys.lastChip));

  expect(filterChip.selected, isTrue);

  await tester.tap(
    find.byKey(KWidgetkeys.filterKeys.popupMenu),
  );

  await tester.pumpAndSettle();
  await tester.tap(
    find.byKey(KWidgetkeys.filterKeys.popupMenuResetAll),
  );
  await tester.pumpAndSettle();

  filterChip =
      tester.widget<FilterChip>(find.byKey(KWidgetkeys.filterKeys.lastChip));

  expect(filterChip.selected, isFalse);
}
