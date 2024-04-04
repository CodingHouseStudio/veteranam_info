import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardTextDetailHelper({
  required WidgetTester tester,
  List<String>? detailButtonText,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.text),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.text),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetail.button),
    findsOneWidget,
  );

  late var text =
      tester.widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetail.widget),
      matching: find.text(
        detailButtonText?.elementAt(0) ?? KTestText.storyCardButtonDetail,
      ),
    ),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: null,
    itemKey: KWidgetkeys.widget.cardTextDetail.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.cardTextDetail.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: null,
    itemKey: KWidgetkeys.widget.cardTextDetail.button,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetail.widget),
      matching: find.text(
        detailButtonText?.elementAt(1) ?? KTestText.storyCardButtonNotDetail,
      ),
    ),
    findsOneWidget,
  );

  text =
      tester.widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text));

  expect(text.maxLines, null);

  await tester.tap(find.byKey(KWidgetkeys.widget.cardTextDetail.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  text =
      tester.widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetail.widget),
      matching: find.text(
        detailButtonText?.elementAt(0) ?? KTestText.storyCardButtonDetail,
      ),
    ),
    findsOneWidget,
  );

  text =
      tester.widget<Text>(find.byKey(KWidgetkeys.widget.cardTextDetail.text));

  expect(text.maxLines, isNotNull);
}
