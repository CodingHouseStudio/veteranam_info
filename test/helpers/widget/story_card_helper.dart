import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> storyCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.storyCardKeys.widget), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.date), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.dislikeIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.image), findsNothing);

  expect(find.byKey(KWidgetkeys.storyCardKeys.likeIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.share), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.text), findsOneWidget);

  expect(find.byKey(KWidgetkeys.storyCardKeys.button), findsOneWidget);

  late var text =
      tester.widget<Text>(find.byKey(KWidgetkeys.storyCardKeys.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.text(KAppText.storyCardButtonDetail),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.button));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.text(KAppText.storyCardButtonNotDetail),
    ),
    findsOneWidget,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.storyCardKeys.text));

  expect(text.maxLines, null);

  await scrollingHelper(
    tester: tester,
    offset: null,
    item: KWidgetkeys.storyCardKeys.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.storyCardKeys.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.text(KAppText.storyCardButtonDetail),
    ),
    findsOneWidget,
  );

  text = tester.widget<Text>(find.byKey(KWidgetkeys.storyCardKeys.text));

  expect(text.maxLines, isNotNull);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.likeIcon));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.activeLike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.likeIcon));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.dislikeIcon));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.activeDislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.storyCardKeys.dislikeIcon));

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.storyCardKeys.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );
}
