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
      //   find.byKey(SignUpKeys.bottomButtons),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(SignUpKeys.button),
        findsOneWidget,
      );

      expect(
        find.byKey(SignUpKeys.card),
        findsOneWidget,
      );

      expect(
        find.byKey(SignUpKeys.fields),
        findsOneWidget,
      );

      expect(
        find.byKey(SignUpKeys.loginButton),
        findsOneWidget,
      );

      expect(
        find.byKey(SignUpKeys.loginText),
        findsOneWidget,
      );

      expect(
        find.byKey(SignUpKeys.title),
        findsOneWidget,
      );

      expect(find.byKey(SignUpKeys.submitingText), findsNothing);

      // await dialogSnackBarTextHelper(tester: tester, showDialog: false);

      await leftCardHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);

      await signUpBottomButtonsHelper(tester);
    },
  );
}
