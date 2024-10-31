import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/text/text_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountCardHelper({
  required WidgetTester tester,
  bool containComplaintIcon = true,
}) async {
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
    containComplaintIcon ? findsWidgets : findsNothing,
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
    containComplaintIcon ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.iconWebsite),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.discountCard.iconWebsite).first,
    warnIfMissed: false,
  );

  if (containComplaintIcon) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.widget.discountCard.iconComplaint,
    );
  }
}
