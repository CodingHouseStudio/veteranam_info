import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> profileLogOutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(ProfileKeys.logOutButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.logOutButton,
  );

  await tester.tap(find.byKey(ProfileKeys.logOutButton));

  await tester.pumpAndSettle();

  await confirmDialogChangesHelper(
    tester: tester,
  );
}
