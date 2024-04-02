import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardTextDetailHelper({
  required WidgetTester tester,
  List<String>? detailButtonText,
}) async {
  expect(find.byKey(KWidgetkeys.cardTextDetailKeys.text), findsOneWidget);

  expect(find.byKey(KWidgetkeys.cardTextDetailKeys.text), findsOneWidget);

  expect(find.byKey(KWidgetkeys.cardTextDetailKeys.button), findsOneWidget);

  late var text =
      tester.widget<Text>(find.byKey(KWidgetkeys.cardTextDetailKeys.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.cardTextDetailKeys.widget),
      matching: find.text(
        detailButtonText?.elementAt(0) ?? KAppText.storyCardButtonDetail,
      ),
    ),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: null,
    itemKey: KWidgetkeys.cardTextDetailKeys.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.cardTextDetailKeys.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: null,
    itemKey: KWidgetkeys.cardTextDetailKeys.button,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.cardTextDetailKeys.widget),
      matching: find.text(
        detailButtonText?.elementAt(1) ?? KAppText.storyCardButtonNotDetail,
      ),
    ),
    findsOneWidget,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.cardTextDetailKeys.text));

  expect(text.maxLines, null);

  await tester.tap(find.byKey(KWidgetkeys.cardTextDetailKeys.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.cardTextDetailKeys.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.cardTextDetailKeys.widget),
      matching: find.text(
        detailButtonText?.elementAt(0) ?? KAppText.storyCardButtonDetail,
      ),
    ),
    findsOneWidget,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.cardTextDetailKeys.text));

  expect(text.maxLines, isNotNull);
}
