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
        find.byKey(KWidgetkeys.screen.userRole.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.userRole.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.userRole.signUpBusinessButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.userRole.signUpUserButton,
      );
      expect(
        find.byKey(KWidgetkeys.screen.userRole.signUpUserButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.userRole.loginButton),
        findsOneWidget,
      );
    },
  );
}
