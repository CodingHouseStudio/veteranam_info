import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> signUpInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      // expect(
      //   find.byKey(KWidgetkeys.screen.signUp.bottomButtons),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.card),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.fields),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.loginButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.loginText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.signUp.title),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.screen.signUp.submitingText), findsNothing);

      // await dialogSnackBarTextHelper(tester: tester, showDialog: false);

      await leftCardHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);

      await signUpBottomButtonsHelper(tester);
    },
  );
}
