import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> cardTextDetailHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.button),
    findsWidgets,
  );

  late var text = tester
      .widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text).first);

  expect(text.maxLines, isNotNull);

  final buttonText = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.cardTextDetail.buttonText).first,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.cardTextDetail.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.cardTextDetail.button).first);

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.cardTextDetail.button,
  );

  expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.cardTextDetail.buttonText).first,
        )
        .data,
    isNot(buttonText.data),
  );

  text = tester.widget<Text>(
    find.byKey(KWidgetkeys.widget.cardTextDetail.text).first,
  );

  expect(text.maxLines, null);

  await tester.tap(find.byKey(KWidgetkeys.widget.cardTextDetail.button).first);

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: KWidgetkeys.widget.cardTextDetail.text,
  );

  text = tester
      .widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text).first);

  expect(text.maxLines, isNotNull);

  expect(
    tester
        .widget<Text>(
          find.byKey(KWidgetkeys.widget.cardTextDetail.buttonText).first,
        )
        .data,
    buttonText.data,
  );

  text = tester
      .widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text).first);

  expect(text.maxLines, isNotNull);
}
