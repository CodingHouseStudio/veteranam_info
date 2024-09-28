import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddMainEnterHelper({
  required WidgetTester tester,
  required String categoryText,
  required String cityText,
  bool tapOnperiod = true,
  bool tapIndefinitely = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.categoryField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.categoryField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.categoryField),
    categoryText,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cityField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    cityText,
  );

  await tester.pumpAndSettle();

  await tester.sendKeyEvent(LogicalKeyboardKey.enter);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.periodField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.periodField,
  );

  if (tapIndefinitely) {
    await tester.tap(
      find.byKey(KWidgetkeys.screen.discountsAdd.indefinitelySwitcher),
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();
  }

  if (tapOnperiod) {
    await tester.tap(
      find.byKey(KWidgetkeys.screen.discountsAdd.periodField),
    );

    await tester.pumpAndSettle();
  }

  await discountsAddSendHelper(tester);
}
