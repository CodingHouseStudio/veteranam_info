import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../helpers/change_window_size_helper.dart';

Future<void> passwordResetWrongCodeHelper(
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
        find.byKey(KWidgetkeys.screen.passwordReset.wrongLinkSubtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.passwordReset.confirmButton),
        findsOneWidget,
      );
    },
  );
}
