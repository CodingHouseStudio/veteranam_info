part of 'filter_box_helper.dart';

Future<void> _filterPopupMenuHelper(
  WidgetTester tester,
) async {
  await tester.tap(
    find.byKey(KWidgetkeys.widget.filterPopupMenu.widget),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.filterPopupMenu.resetAll),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.filterPopupMenu.resetAll),
  );

  await tester.pumpAndSettle();
}
