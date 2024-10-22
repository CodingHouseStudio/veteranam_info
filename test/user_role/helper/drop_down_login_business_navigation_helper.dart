import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> dropDownLoginBusinessNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await dropDownButtonNavigationHelper(
    mockGoRouter: mockGoRouter,
    tester: tester,
  );

  expect(
    find.byKey(KWidgetkeys.screen.userRole.loginBusinessButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.userRole.loginBusinessButton));

  await tester.pumpAndSettle();
}
