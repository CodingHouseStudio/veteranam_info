import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> filterPopupMenuHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: FilterPopupMenuKeys.widget,
  );

  await tester.tap(
    find.byKey(FilterPopupMenuKeys.widget),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(FilterPopupMenuKeys.resetAll),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(FilterPopupMenuKeys.resetAll),
  );

  await tester.pumpAndSettle();
}
