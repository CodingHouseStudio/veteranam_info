import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> filterPopupMenuHelper(
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
