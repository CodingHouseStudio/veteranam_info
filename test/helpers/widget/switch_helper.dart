import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

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

  await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  await tester.pumpAndSettle();

  switchWidget =
      tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  expect(switchWidget.value, isTrue);

  await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  await tester.pumpAndSettle();

  switchWidget =
      tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  expect(switchWidget.value, isFalse);
}
