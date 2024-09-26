import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> profileformsHelper({
  required WidgetTester tester,
  required String? name,
  required String? surname,
  required String? nickname,
}) async {
  await profileFormFieldHelper(tester);

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.photo));

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.nameField,
  );

  if (name != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.profile.nameField),
      name,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.lastNameField,
  );

  if (surname != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.profile.lastNameField),
      surname,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.emailFied,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.nickNameField,
  );

  if (nickname != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.screen.profile.nickNameField),
      nickname,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.saveButton,
  );

  // await tester.tap(find.byKey(KWidgetkeys.screen.profile.saveButton));

  // await tester.pumpAndSettle();
}
