import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> dropListFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  // String? Function()? itemTextWidget,
  bool hasMultiChoice = false,
  // int fieldIndex = 0,
  // Key? fieldKey,
  bool hasValue = false,
}) async {
  await dropListFieldItemHelper(
    tester: tester,
    textFieldKey: textFieldKey,
    // itemTextWidget: itemTextWidget,
    // fieldKey: fieldKey,
    hasMultiChoice: hasMultiChoice,
    hasValue: hasValue,
  );

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(textFieldKey),
    text,
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(textFieldKey),
      matching: find.text(text),
    ),
    findsWidgets,
  );

  await tester.enterText(
    find.byKey(textFieldKey),
    '',
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DropListFieldKeys.activeIcon).first,
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(DropListFieldKeys.item),
  //   findsNothing,
  // );
}
