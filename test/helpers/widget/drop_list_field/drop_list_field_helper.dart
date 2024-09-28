import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dropListFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  String? Function()? itemTextWidget,
  int fieldIndex = 0,
}) async {
  await dropListFieldItemHelper(
    tester: tester,
    textFieldKey: textFieldKey,
    itemTextWidget: itemTextWidget,
    fieldIndex: fieldIndex,
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
    find.byKey(KWidgetkeys.widget.dropListField.activeIcon).first,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.dropListField.item),
  //   findsNothing,
  // );
}
