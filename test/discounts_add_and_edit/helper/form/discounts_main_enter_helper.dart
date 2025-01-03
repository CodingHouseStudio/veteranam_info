import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddMainEnterHelper({
  required WidgetTester tester,
  required String titleText,
  required String linkText,
  required String discountsText,
  required bool eligibilityTap,
  bool isEdit = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.titleField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.titleField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.titleField),
    titleText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.discountsField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.discountsField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.discountsField),
    discountsText,
  );

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.eligibilityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.eligibilityField,
  );

  if (eligibilityTap) {
    await dropListFieldItemHelper(
      tester: tester,
      textFieldKey: KWidgetkeys.screen.discountsAdd.eligibilityField,
      hasMultiChoice: true,
      hasValue: isEdit,
    );
  }

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.linkField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.linkField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.linkField),
    linkText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}
