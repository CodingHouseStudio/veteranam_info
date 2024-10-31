import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> dropDownButtonNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    itemKey: KWidgetkeys.widget.dropDownButton.loginButton,
  );

  expect(
    find.byKey(KWidgetkeys.widget.dropDownButton.loginButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropDownButton.loginButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(KWidgetkeys.screen.userRole.loginBusinessButton),
  //   findsOneWidget,
  // );

  // // await tester
  // //     .tap(find.byKey(KWidgetkeys.screen.userRole.loginBusinessButton));

  // // await tester.pumpAndSettle();

  // expect(
  //   find.byKey(KWidgetkeys.screen.userRole.loginUserButton),
  //   findsOneWidget,
  // );

  // // await scrollingHelper(
  // //   tester: tester,
  // //   itemKey: KWidgetkeys.screen.userRole.loginUserButton,
  // // );

  // await tester.tap(find.byKey(KWidgetkeys.screen.userRole.loginUserButton));

  // await tester.pumpAndSettle();

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.login.name),
  // ).called(1);
}
