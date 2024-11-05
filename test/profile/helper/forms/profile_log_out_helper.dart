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
    find.byKey(KWidgetkeys.screen.profile.logOutButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.logOutButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.logOutButton));

  await tester.pumpAndSettle();

  await dialogConfirmChangesHelper(
    tester: tester,
  );
}
