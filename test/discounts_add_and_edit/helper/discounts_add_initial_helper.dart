import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> discountsAddInitialHelper({
  required WidgetTester tester,
  bool isEdit = false,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(DiscountsAddKeys.textWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(DiscountsAddKeys.imageWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(DiscountsAddKeys.buttonWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(DiscountsAddKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(DiscountsAddKeys.pageIndicator),
        findsOneWidget,
      );

      await discountsAddMainHelper(tester: tester);

      await scrollingHelper(
        tester: tester,
        itemKey: DiscountsAddKeys.titleField,
      );

      if (!isEdit) {
        await multiDropFieldHelper(
          tester: tester,
          text: KTestVariables.field,
          textFieldKey: DiscountsAddKeys.discountsField,
          // fieldKey: 1,
          // hasItem: isEdit,
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.enter);

        await tester.pumpAndSettle();

        await eligibilityFieldHelper(
          tester: tester,
          fieldIndex: isEdit ? 4 : 2,
        );
      }

      // await multiDropFieldRemoveHelper(tester);

      expect(
        find.byKey(DropListFieldKeys.list),
        findsNothing,
      );

      expect(
        find.byKey(DiscountsAddKeys.cancelButton),
        findsOneWidget,
      );
    },
  );
}
