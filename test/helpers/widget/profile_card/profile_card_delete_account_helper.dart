import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardDeleteAccountHelper(
  WidgetTester tester,
) async {
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

  await dialogDeleteAccountHelper(tester);
}
