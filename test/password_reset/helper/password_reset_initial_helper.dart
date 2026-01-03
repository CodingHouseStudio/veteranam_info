import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../helpers/change_window_size_helper.dart';

Future<void> passwordResetInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(PasswordResetKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(PasswordResetKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(PasswordResetKeys.passwordField),
        findsOneWidget,
      );

      expect(
        find.byKey(PasswordResetKeys.confirmPasswordField),
        findsOneWidget,
      );

      expect(
        find.byKey(PasswordResetKeys.confirmButton),
        findsOneWidget,
      );
    },
  );
}
