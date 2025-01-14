import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> profileFormsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.photo),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profile.nameField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profile.lastNameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.lastNameField,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profile.emailFied),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.emailFied,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.profile.nickNameField),
  //   findsOneWidget,
  // );

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: KWidgetkeys.screen.profile.nickNameField,
  // );

  expect(
    find.byKey(KWidgetkeys.screen.profile.saveButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.saveButton,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
