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
}
