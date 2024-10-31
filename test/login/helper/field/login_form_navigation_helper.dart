import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> loginFormNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.login.fields),
    findsOneWidget,
  );

  await emailPasswordFieldsEmHelper(
    tester: tester,
    email: KTestText.userEmail,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.login.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.login.button));

  await tester.pumpAndSettle();

  await emailPasswordFieldsNavigationHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
