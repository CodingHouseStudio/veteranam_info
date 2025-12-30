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
    find.byKey(DiscountsAddKeys.titleField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.titleField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.titleField),
    titleText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.discountsField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.discountsField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.discountsField),
    discountsText,
  );

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.eligibilityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.eligibilityField,
  );

  if (eligibilityTap) {
    await eligibilityFieldHelper(
      tester: tester,
      hasValue: isEdit,
      removeAfter: false,
    );
  }

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.linkField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.linkField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.linkField),
    linkText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}
