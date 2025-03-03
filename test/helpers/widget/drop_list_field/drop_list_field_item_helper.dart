import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> dropListFieldItemHelper({
  required WidgetTester tester,
  required Key textFieldKey,
  // String? Function()? itemTextWidget,
  // int fieldIndex = 0,
  // Key? fieldKey,
  bool hasMultiChoice = false,
  bool hasValue = false,
}) async {
  expect(
    find.byKey(DropListFieldKeys.widget),
    findsWidgets,
  );

  expect(
    find.byKey(textFieldKey),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(DropListFieldKeys.list),
  //   findsNothing,
  // );

  expect(
    find.byKey(DropListFieldKeys.item),
    findsNothing,
  );

  expect(
    find.byKey(DropListFieldKeys.icon),
    findsWidgets,
  );

  expect(
    find.byKey(DropListFieldKeys.activeIcon),
    findsNothing,
  );

  // expect(
  //   find.descendant(
  //     of: find.byKey(DropListFieldKeys.list),
  //     matching: find.byKey(DropListFieldKeys.item),
  //   ),
  //   findsNothing,
  // );

  expect(
    find.byKey(DropListFieldKeys.item),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DropListFieldKeys.widget,
  );

  if (!hasValue) {
    await tester.tap(
      find.byKey(textFieldKey),
      warnIfMissed: false,
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(DropListFieldKeys.activeIcon),
      findsOneWidget,
    );

    expect(
      find.byKey(DropListFieldKeys.list),
      findsOneWidget,
    );

    expect(
      find.byKey(DropListFieldKeys.item),
      findsWidgets,
    );

    // if (itemTextWidget == null) {
    //   expect(
    //     find.byKey(DropListFieldKeys.itemText),
    //     findsWidgets,
    //   );
    // }

    expect(
      find.byKey(DropListFieldKeys.activeIcon),
      findsOneWidget,
    );

    // expect(
    //   find.byKey(DropListFieldKeys.item),
    //   findsWidgets,
    // );

    // final text = itemTextWidget?.call() ??
    //     tester
    //         .widget<Text>(
    //           find.byKey(DropListFieldKeys.itemText).first,
    //         )
    //         .data;

    await tester.tap(
      find.byKey(DropListFieldKeys.item).first,
    );

    await tester.pumpAndSettle();

    expect(
      find.byKey(DropListFieldKeys.activeIcon),
      findsNothing,
    );

    expect(
      find.byKey(DropListFieldKeys.item),
      findsNothing,
    );

    expect(
      find.byKey(DropListFieldKeys.list),
      findsNothing,
    );

    // if (!hasMultiChoice) {
    //   expect(
    //     find.descendant(
    //       of: find.byKey(DropListFieldKeys.widget),
    //       matching: find.text(text ?? ''),
    //     ),
    //     findsOneWidget,
    //   );
    // }
  }
}
