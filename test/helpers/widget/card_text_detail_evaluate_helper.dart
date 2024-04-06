import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cardTextDetailEvaluateHelper({
  required WidgetTester tester,
  List<String>? detailButtonText,
}) async {
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
    tester: tester,
    detailButtonText: detailButtonText,
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
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(
      KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike,
    ),
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike),
    findsNothing,
  );
}
