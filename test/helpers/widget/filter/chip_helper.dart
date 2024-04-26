import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> chipHelper(WidgetTester tester) async {
  await tester.pump();

  expect(find.byKey(KWidgetkeys.widget.dropChip.widget), findsWidgets);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropChip.widget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropChip.widget).first,
    warnIfMissed: false,
  );

  await tester.pump(const Duration(milliseconds: 500));
  await tester.pumpAndSettle();

  expect(find.text('Пільги'), findsNothing);
}
