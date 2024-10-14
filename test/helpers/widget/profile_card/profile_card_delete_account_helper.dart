import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardDeleteAccountHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profile.deleteButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.deleteButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.deleteButton));

  await tester.pumpAndSettle();

  await dialogConfirmChangesHelper(tester);
}
