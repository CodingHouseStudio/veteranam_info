import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddDetailEnterHelper({
  required WidgetTester tester,
  required String categoryText,
  required String cityText,
  bool tapOnperiod = true,
  bool tapIndefinitely = false,
}) async {
  expect(
    find.byKey(DiscountsAddKeys.categoryField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.categoryField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.categoryField),
    categoryText,
  );

  expect(
    find.byKey(DiscountsAddKeys.cityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.cityField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.cityField),
    cityText,
  );

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.onlineSwitcher,
  );

  await tester.tap(
    find.byKey(DiscountsAddKeys.onlineSwitcher),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DiscountsAddKeys.onlineSwitcher),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.periodField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.periodField,
  );

  if (tapIndefinitely) {
    await tester.tap(
      find.byKey(DiscountsAddKeys.indefinitelySwitcher),
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();
  }

  if (tapOnperiod) {
    await tester.tap(
      find.byKey(DiscountsAddKeys.periodField),
    );

    await tester.pumpAndSettle();
  }

  await discountsAddSendHelper(tester);
}
