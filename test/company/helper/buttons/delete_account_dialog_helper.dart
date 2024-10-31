import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> deleteAccountDialoglHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.company.deleteButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.deleteButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.company.deleteButton));

  await tester.pumpAndSettle();
}
