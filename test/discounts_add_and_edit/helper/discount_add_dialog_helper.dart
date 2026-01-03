import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountsAddDialogHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(DiscountsAddKeys.cancelButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.cancelButton,
  );

  await tester.tap(find.byKey(DiscountsAddKeys.cancelButton));

  await tester.pumpAndSettle();

  await confirmDialogChangesHelper(
    tester: tester,
  );
}
