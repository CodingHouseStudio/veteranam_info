import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardLogOutHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.profileCard.logOutButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCard.logOutButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.profileCard.logOutButton));

  await tester.pumpAndSettle();

  await dialogLogOutHelper(tester);
}
