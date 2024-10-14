import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsAddDialogHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cancelButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton));

  await tester.pumpAndSettle();

  await dialogConfirmChangesHelper(tester);
}
