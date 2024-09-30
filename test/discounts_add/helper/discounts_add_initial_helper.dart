import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> discountsAddInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
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
        text: KTestText.field,
        textFieldKey: KWidgetkeys.screen.discountsAdd.discountsField,
        fieldIndex: 1,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.sendButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton),
        findsOneWidget,
      );
    },
  );
}
