import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardLogOutHelper(
  WidgetTester tester,
) async {
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

  await dialogLogOutHelper(tester);
}
