import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileFormsIncorrectSaveHelper({
  required WidgetTester tester,
  required String name,
  required String surname,
  required String nickname,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.photo,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.photo));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.nameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.profile.nameField),
    name,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.lastNameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.profile.lastNameField),
    surname,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.emailFied,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.nickNameField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.profile.nickNameField),
    nickname,
  );

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.nickNameField,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.saveButton));

  await tester.pumpAndSettle();
}
