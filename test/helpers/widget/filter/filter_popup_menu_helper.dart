import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> filterPopupMenuHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.filterPopupMenu.widget,
  );

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
