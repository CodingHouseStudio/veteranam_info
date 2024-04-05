import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardTextDetailEvaluateHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconSmile),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconShare),
    findsOneWidget,
  );

  await cardTextDetailHelper(
    tester,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.cardTextDetailEvaluate.iconLike,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.activeLike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.activeDislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike,
    ),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );
}
