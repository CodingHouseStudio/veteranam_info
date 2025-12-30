import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> profileFormsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ProfileKeys.photo),
    findsOneWidget,
  );

  expect(
    find.byKey(ProfileKeys.nameField),
    findsOneWidget,
  );

  expect(
    find.byKey(ProfileKeys.lastNameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.lastNameField,
  );

  expect(
    find.byKey(ProfileKeys.emailFied),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.emailFied,
  );

  // expect(
  //   find.byKey(ProfileKeys.nickNameField),
  //   findsOneWidget,
  // );

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: ProfileKeys.nickNameField,
  // );

  expect(
    find.byKey(ProfileKeys.saveButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.saveButton,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );
}
