import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(ProfileKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(ProfileKeys.photo),
        findsOneWidget,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: ProfileKeys.subtitle,
      // );

      expect(
        find.byKey(ProfileKeys.nameField),
        findsOneWidget,
      );

      expect(
        find.byKey(ProfileKeys.emailFied),
        findsOneWidget,
      );

      expect(
        find.byKey(ProfileKeys.lastNameField),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(ProfileKeys.nickNameField),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(ProfileKeys.saveButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: ProfileKeys.saveButton,
      );

      // expect(
      //   find.byKey(ProfileKeys.deleteButton),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(ProfileKeys.logOutButton),
        findsOneWidget,
      );

      //await profileCardHelper(tester);
    },
  );
}
