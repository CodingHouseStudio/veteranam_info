import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> multiDropFieldHelper({
  required WidgetTester tester,
  required String text,
  required Key textFieldKey,
  String? Function()? itemTextWidget,
  int fieldIndex = 0,
  bool hasItem = false,
}) async {
  await dropListFieldHelper(
    tester: tester,
    text: text,
    textFieldKey: textFieldKey,
    fieldIndex: fieldIndex,
    itemTextWidget: itemTextWidget,
    hasMultiChoice: true,
    hasValue: hasItem,
  );

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DropListFieldKeys.item).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(MultiDropFieldKeys.chips),
    hasItem ? findsWidgets : findsOneWidget,
  );

  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DropListFieldKeys.item).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(MultiDropFieldKeys.chips),
    hasItem ? findsWidgets : findsOneWidget,
  );
  await tester.tap(
    find.byKey(textFieldKey),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  await tester.tap(
    find.byKey(DropListFieldKeys.item).at(1),
  );

  await tester.pumpAndSettle();

  expect(find.byKey(MultiDropFieldKeys.chips), findsWidgets);

  await tester.tap(find.byKey(MultiDropFieldKeys.chips).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(MultiDropFieldKeys.chips),
    hasItem ? findsWidgets : findsOneWidget,
  );

  await tester.tap(find.byKey(MultiDropFieldKeys.chips).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(MultiDropFieldKeys.chips),
    hasItem ? findsWidgets : findsNothing,
  );
}
