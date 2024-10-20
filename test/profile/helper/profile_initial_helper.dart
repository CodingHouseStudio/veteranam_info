import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.profile.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.photo),
        findsOneWidget,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: KWidgetkeys.screen.profile.subtitle,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.profile.nameField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.emailFied),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.lastNameField),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.profile.nickNameField),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.profile.saveButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.profile.saveButton,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.profile.deleteButton),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.profile.logOutButton),
        findsOneWidget,
      );

      //await profileCardHelper(tester);
    },
  );
}
