import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> loginInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(LoginKeys.screen), findsOneWidget);

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  // expect(
  //   find.byKey(LoginKeys.bottomButtons),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(LoginKeys.button),
    findsOneWidget,
  );

  expect(
    find.byKey(LoginKeys.card),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(LoginKeys.fields),
    findsOneWidget,
  );

  expect(
    find.byKey(LoginKeys.signUpButton),
    findsOneWidget,
  );

  expect(
    find.byKey(LoginKeys.signUpText),
    findsOneWidget,
  );

  expect(
    find.byKey(LoginKeys.title),
    findsOneWidget,
  );

  await dialogSnackBarTextHelper(tester: tester, showDialog: false);

  await leftCardHelper(tester);

  await emailPasswordFieldsHelper(tester: tester, showPassword: false);

  await signUpBottomButtonsHelper(tester);
}
