import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> cardTextDetailEvaluateHelper(
  WidgetTester tester,
) async {
  expect(
    //find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconShare),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconWebsite),
    findsNothing,
  );
/*
  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveSmile),
    findsNothing,
  );
*/
  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconShare),
    findsWidgets,
  );

  await cardTextDetailHelper(
    tester,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.cardTextDetailEvaluate.iconLike,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike).first,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconLike),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveLike),
    findsNothing,
  );

  /*
 await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike),
    findsOneWidget,
  );

  await tester.tap(
    find
        .byKey(
          KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike,
        )
        .first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconDislike),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveDislike),
    findsNothing,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconSmile).first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveSmile),
    findsOneWidget,
  );

  await tester.tap(
    find
        .byKey(
          KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveSmile,
        )
        .first,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconSmile),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardTextDetailEvaluate.iconActiveSmile),
    findsNothing,
  );
  */
}
