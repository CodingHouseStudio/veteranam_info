import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> multiDropFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  String? Function()? itemTextWidget,
  int fieldIndex = 0,
}) async {
  await dropListFieldHelper(
    tester: tester,
    text: text,
    textFieldKey: textFieldKey,
    fieldIndex: fieldIndex,
    itemTextWidget: itemTextWidget,
    hasMultiChoice: true,
  );

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.item).first,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.item).first,
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(KWidgetkeys.widget.dropListField.item).at(1),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsWidgets);

  await tester.tap(find.byKey(KWidgetkeys.widget.multiDropField.chips).first);

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.multiDropField.chips).first);

  await tester.pumpAndSettle();

  expect(find.byKey(KWidgetkeys.widget.multiDropField.chips), findsNothing);
}
