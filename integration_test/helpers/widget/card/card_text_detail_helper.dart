import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> cardTextDetailHelper(WidgetTester tester) async {
  expect(
    find.byKey(CardTextDetailKeys.text),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailKeys.text),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailKeys.button),
    findsWidgets,
  );

  // late var text = tester
  //     .widget<Text>(find.byKey(CardTextDetailKeys.text).
  // first);

  // expect(text.maxLines, isNotNull);

  final buttonText = tester.widget<Text>(
    find.byKey(CardTextDetailKeys.buttonText).first,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: CardTextDetailKeys.button,
  );

  await tester.tap(find.byKey(CardTextDetailKeys.button).first);

  await tester.pumpAndSettle();

  await scrollingHelperInt(
    tester: tester,
    itemKey: CardTextDetailKeys.button,
  );

  expect(
    tester
        .widget<Text>(
          find.byKey(CardTextDetailKeys.buttonText).first,
        )
        .data,
    isNot(buttonText.data),
  );

  // text = tester.widget<Text>(
  //   find.byKey(CardTextDetailKeys.text).first,
  // );

  // expect(text.maxLines, null);

  await tester.tap(find.byKey(CardTextDetailKeys.button).first);

  await tester.pumpAndSettle();

  await scrollingHelperInt(
    tester: tester,
    itemKey: CardTextDetailKeys.text,
  );

  // text = tester
  //     .widget<Text>(find.byKey(CardTextDetailKeys.text).
  // first);

  // expect(text.maxLines, isNotNull);

  expect(
    tester
        .widget<Text>(
          find.byKey(CardTextDetailKeys.buttonText).first,
        )
        .data,
    buttonText.data,
  );

  // text = tester
  //     .widget<Text>(find.byKey(CardTextDetailKeys.text).
  // first);

  // expect(text.maxLines, isNotNull);
}
