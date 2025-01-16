import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> userRoleInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(UserRoleKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(UserRoleKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(UserRoleKeys.signUpBusinessButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: UserRoleKeys.signUpUserButton,
      );
      expect(
        find.byKey(UserRoleKeys.signUpUserButton),
        findsOneWidget,
      );

      expect(
        find.byKey(UserRoleKeys.loginButton),
        findsOneWidget,
      );
    },
  );
}
