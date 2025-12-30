import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> pwResetEmailInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(PwResetEmailKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(PwResetEmailKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(PwResetEmailKeys.emailField),
        findsOneWidget,
      );

      expect(find.text(KTestVariables.userEmailIncorrect), findsOneWidget);

      expect(
        find.byKey(PwResetEmailKeys.sendButton),
        findsOneWidget,
      );
    },
  );
}
