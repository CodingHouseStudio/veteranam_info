import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> profileFormsEnterTextHelper({
  required WidgetTester tester,
  required String name,
  required String surname,
  required String nickname,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.photo,
  );

  await tester.tap(find.byKey(ProfileKeys.photo));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.nameField,
  );

  await tester.enterText(
    find.byKey(ProfileKeys.nameField),
    name,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.lastNameField,
  );

  await tester.enterText(
    find.byKey(ProfileKeys.lastNameField),
    surname,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: ProfileKeys.emailFied,
  );

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: ProfileKeys.nickNameField,
  // );

  // await tester.enterText(
  //   find.byKey(ProfileKeys.nickNameField),
  //   nickname,
  // );

  // await tester.pumpAndSettle();

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: ProfileKeys.nickNameField,
  // );
}
