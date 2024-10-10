import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../helpers/change_window_size_helper.dart';

Future<void> passwordResetInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.passwordField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.confirmPasswordField),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.confirmButton),
        findsOneWidget,
      );
    },
  );
}
