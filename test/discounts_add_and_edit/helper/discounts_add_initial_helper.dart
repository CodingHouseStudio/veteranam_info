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
        find.byKey(KWidgetkeys.screen.discountsAdd.textWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.imageWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.buttonWrongLink),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.pageIndicator),
        findsOneWidget,
      );

      await discountsAddMainHelper(tester: tester);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.discountsAdd.titleField,
      );

      await multiDropFieldHelper(
        tester: tester,
        text: KTestVariables.field,
        textFieldKey: KWidgetkeys.screen.discountsAdd.discountsField,
        fieldIndex: 1,
        hasItem: isEdit,
      );

      await dropListFieldItemHelper(
        tester: tester,
        textFieldKey: KWidgetkeys.screen.discountsAdd.eligibilityField,
        fieldIndex: isEdit ? 4 : 2,
        hasMultiChoice: true,
        hasValue: isEdit,
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      await tester.pumpAndSettle();

      await multiDropFieldRemoveHelper(tester);

      expect(
        find.byKey(KWidgetkeys.widget.dropListField.list),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton),
        findsOneWidget,
      );
    },
  );
}
