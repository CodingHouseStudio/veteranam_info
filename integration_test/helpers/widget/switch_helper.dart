import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> switchHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.switchKeys.widget),
    findsOneWidget,
  );

  late var switchWidget =
      tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  expect(switchWidget.value, isFalse);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.switchKeys.widget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  await tester.pumpAndSettle();

  switchWidget =
      tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  expect(switchWidget.value, isTrue);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.switchKeys.widget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  await tester.pumpAndSettle();

  switchWidget =
      tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  expect(switchWidget.value, isFalse);
}
