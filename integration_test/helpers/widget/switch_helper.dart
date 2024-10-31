import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> switchHelper({
  required WidgetTester tester,
  bool enabled = true,
  bool isActive = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.switchKeys.widget),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.switchKeys.icon),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.widget.switchKeys.item),
  //   findsWidgets,
  // );

  expect(
    tester
        .widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget))
        .value,
    isActive ? isTrue : isFalse,
  );

  // late var switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget)
  // );

  // expect(switchWidget.value, isFalse);
  if (enabled) {
    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.widget.switchKeys.widget,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

    await tester.pumpAndSettle();

    expect(
      tester
          .widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget))
          .value,
      isTrue,
    );

    await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

    await tester.pumpAndSettle();

    expect(
      tester
          .widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget))
          .value,
      isFalse,
    );
  }

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget
  // ));

  // expect(switchWidget.value, isTrue);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: KWidgetkeys.widget.switchKeys.widget,
  // );

  // await tester.tap(find.byKey(KWidgetkeys.widget.switchKeys.widget));

  // await tester.pumpAndSettle();

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(KWidgetkeys.widget.switchKeys.widget
  // ));

  // expect(switchWidget.value, isFalse);
}
