import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> profileDeleteButtonHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(ProfileKeys.deleteButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.deleteButton,
  );

  await tester.tap(find.byKey(ProfileKeys.deleteButton));

  await tester.pumpAndSettle();

  await confirmDialogChangesHelper(
    tester: tester,
  );
}
