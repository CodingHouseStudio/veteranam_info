import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> loginInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.login.bottomButtons),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.login.button),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.card),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.fields),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.signUpButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.signUpText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.login.title),
        findsOneWidget,
      );

      expect(find.byKey(KWidgetkeys.screen.login.submitingText), findsNothing);
      // await dialogSnackBarTextHelper(tester: tester, showDialog: false);

      await leftCardHelper(tester);

      await emailPasswordFieldsHelper(tester: tester, showPassword: false);

      await signUpBottomButtonsHelper(tester);
    },
  );
}
