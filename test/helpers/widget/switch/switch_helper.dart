import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> switchHelper({
  required WidgetTester tester,
  bool enabled = true,
  bool isActive = false,
  int elementIndex = 0,
}) async {
  expect(
    find.byKey(SwitchKeys.widget),
    findsWidgets,
  );

  // expect(
  //   find.byKey(SwitchKeys.icon),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(SwitchKeys.item),
  //   findsWidgets,
  // );

  expect(
    tester
        .widget<Switch>(
          find.byKey(SwitchKeys.widget).at(elementIndex),
        )
        .value,
    isActive ? isTrue : isFalse,
  );

  // late var switchWidget =
  //     tester.widget<Switch>(find.byKey(SwitchKeys.widget)
  // );

  // expect(switchWidget.value, isFalse);
  if (enabled) {
    await scrollingHelper(
      tester: tester,
      itemKey: SwitchKeys.widget,
    );

    await tester.tap(find.byKey(SwitchKeys.widget).at(elementIndex));

    await tester.pumpAndSettle();

    expect(
      tester
          .widget<Switch>(
            find.byKey(SwitchKeys.widget).at(elementIndex),
          )
          .value,
      isActive ? isFalse : isTrue,
    );

    await tester.tap(find.byKey(SwitchKeys.widget).at(elementIndex));

    await tester.pumpAndSettle();

    expect(
      tester
          .widget<Switch>(
            find.byKey(SwitchKeys.widget).at(elementIndex),
          )
          .value,
      isActive ? isTrue : isFalse,
    );
  }

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(SwitchKeys.widget
  // ));

  // expect(switchWidget.value, isTrue);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: SwitchKeys.widget,
  // );

  // await tester.tap(find.byKey(SwitchKeys.widget));

  // await tester.pumpAndSettle();

  // switchWidget =
  //     tester.widget<Switch>(find.byKey(SwitchKeys.widget
  // ));

  // expect(switchWidget.value, isFalse);
}
