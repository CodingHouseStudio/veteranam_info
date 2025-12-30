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
        find.byKey(QuestionsFormKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(QuestionsFormKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(QuestionsFormKeys.roleTitle),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(QuestionsFormKeys.roleVeteranText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(QuestionsFormKeys.roleVeteran),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(QuestionsFormKeys
      // .roleRelativeOfVeteranText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(QuestionsFormKeys.roleRelativeOfVeteran),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(QuestionsFormKeys.roleCivilianText),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(QuestionsFormKeys.roleCivilian),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(QuestionsFormKeys.roleBusinessmenText),
      //   findsOneWidget,
      // );

      await scrollingHelper(
        tester: tester,
        itemKey: QuestionsFormKeys.roleCivilian,
      );

      expect(
        find.byKey(QuestionsFormKeys.roleBusinessmen),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: QuestionsFormKeys.roleBusinessmen,
      );

      expect(
        find.byKey(QuestionsFormKeys.button),
        findsOneWidget,
      );
    },
  );

  await chekPointHelper(tester: tester, twiceTap: false, isEmpty: false);
}
