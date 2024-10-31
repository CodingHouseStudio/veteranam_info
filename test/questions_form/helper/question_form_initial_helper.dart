import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> questionForminitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleTitle),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.questionsForm.roleVeteranText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleVeteran),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.questionsForm
      // .roleRelativeOfVeteranText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleRelativeOfVeteran),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.questionsForm.roleCivilianText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleCivilian),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmenText),
      //   findsOneWidget,
      // );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.questionsForm.roleCivilian,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.roleBusinessmen),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.questionsForm.roleBusinessmen,
      );

      expect(
        find.byKey(KWidgetkeys.screen.questionsForm.button),
        findsOneWidget,
      );
    },
  );

  await chekPointHelper(tester: tester, twiceTap: false);
}
