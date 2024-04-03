import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardTextDetailEvaluateHelper({
  required WidgetTester tester,
  List<String>? detailButtonText,
}) async {
  expect(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconDislike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconSmile),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconLike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconShare),
    findsOneWidget,
  );

  await cardTextDetailHelper(
    tester: tester,
    detailButtonText: detailButtonText,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    offset: null,
    itemKey: KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconLike,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconLike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.activeLike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconLike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.like.icon!),
    ),
    findsOneWidget,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconDislike),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.activeDislike.icon!),
    ),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.iconDislike,
    ),
  );

  await tester.pumpAndSettle();

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.cardTextDetailEvaluateKeys.widget),
      matching: find.byIcon(KIcon.dislike.icon!),
    ),
    findsOneWidget,
  );
}
