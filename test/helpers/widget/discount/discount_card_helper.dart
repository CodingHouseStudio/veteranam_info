import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> discountCardHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.discountCard.service),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.userName),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.date),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.category),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.discountTitle),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.discount),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.expiration),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.city),
    findsWidgets,
  );

  await cityListHelper(tester);

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.description),
    findsWidgets,
  );

  await cardTextDetailHelper(tester: tester, link: KAppText.email);

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.iconShare),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.discountCard.iconShare).first,
    warnIfMissed: false,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.iconWebsite),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.discountCard.iconWebsite).first,
    warnIfMissed: false,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.discountCard.iconComplaint,
  );
}