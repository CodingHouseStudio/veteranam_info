import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> companyLogOutHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.company.logOutButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.company.logOutButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.company.logOutButton));

  await tester.pumpAndSettle();

  await dialogConfirmChangesHelper(tester);
}
