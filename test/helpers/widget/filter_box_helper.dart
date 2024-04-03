import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> filterBoxHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.filter.chips), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.filter.popupMenu),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.filter.lastChip),
  );
  await tester.pumpAndSettle();

  late var filterChip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.filter.lastChip),
  );

  expect(filterChip.selected, isTrue);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.filter.popupMenu),
  );

  await tester.pumpAndSettle();
  await tester.tap(
    find.byKey(KWidgetkeys.widget.filter.popupMenuResetAll),
  );
  await tester.pumpAndSettle();

  filterChip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.filter.lastChip),
  );

  expect(filterChip.selected, isFalse);
}
