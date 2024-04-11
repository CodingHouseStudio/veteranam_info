part of 'filter_box_helper.dart';

Future<void> _chipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.chip.widget), findsWidgets);

  await tester.tap(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );
  await tester.pumpAndSettle();

  late var chip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );

  expect(chip.selected, isTrue);

  await _filterPopupMenuHelper(tester);

  chip = tester.widget<FilterChip>(
    find.byKey(KWidgetkeys.widget.chip.widget).first,
  );

  expect(chip.selected, isFalse);
}
