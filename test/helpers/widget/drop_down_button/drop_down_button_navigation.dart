import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

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

  await tester.tap(find.byKey(KWidgetkeys.widget.dropDownButton.loginButton));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropDownButton.businessButton),
    findsOneWidget,
  );

  // await tester
  //     .tap(find.byKey(KWidgetkeys.widget.dropDownButton.businessButton));

  // await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.dropDownButton.userButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.dropDownButton.userButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.dropDownButton.userButton));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.login.name),
  ).called(1);
}
