import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> cardTextDetailEvaluateHelper({
  required WidgetTester tester,
  String? link,
}) async {
  expect(
    //find.byKey(CardTextDetailEvaluateKeys.iconDislike),
    find.byKey(CardTextDetailEvaluateKeys.iconShare),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconWebsite),
    findsNothing,
  );
/*
  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveSmile),
    findsNothing,
  );
*/
  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconLike),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconShare),
    findsWidgets,
  );

  await cardTextDetailHelper(
    tester: tester,
    link: link,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: CardTextDetailEvaluateKeys.iconLike,
  );

  await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconLike).first,
  );

  await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconLike).first,
  );

  await tester.pumpAndSettle(const Duration(seconds: 6));

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveLike),
    findsNothing,
  );

  await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconLike).first,
  );

  await tester.pumpAndSettle(const Duration(seconds: 6));

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveLike),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveLike).first,
  );

  await tester.pumpAndSettle(const Duration(seconds: 6));

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconLike),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveLike),
    findsNothing,
  );

  /*
 await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconDislike).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveDislike),
    findsOneWidget,
  );

  await tester.tap(
    find
        .byKey(
          CardTextDetailEvaluateKeys.iconActiveDislike,
        )
        .first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconDislike),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveDislike),
    findsNothing,
  );

  await tester.tap(
    find.byKey(CardTextDetailEvaluateKeys.iconSmile).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveSmile),
    findsOneWidget,
  );

  await tester.tap(
    find
        .byKey(
          CardTextDetailEvaluateKeys.iconActiveSmile,
        )
        .first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconSmile),
    findsWidgets,
  );

  expect(
    find.byKey(CardTextDetailEvaluateKeys.iconActiveSmile),
    findsNothing,
  );
  */
}
