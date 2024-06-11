import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> languageSwitcherHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widgetMobile),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widgetMobile),
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
    findsWidgets,
  );

  final textWidget = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile).last,
  );
  await tester.pumpAndSettle();

  expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
        )
        .data,
    isNot(textWidget.data),
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.widgetMobile),
  );
  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile).last,
  );
  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.languageSwitcher.itemMobile).first,
  );
  await tester.pumpAndSettle();

  expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.languageSwitcher.textMobile),
        )
        .data,
    textWidget.data,
  );
}
