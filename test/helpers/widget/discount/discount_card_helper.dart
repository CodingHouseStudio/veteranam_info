import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
// import 'package:veteranam/shared/constants/text/text_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountCardHelper({
  required WidgetTester tester,
  bool containComplaintIcon = true,
}) async {
  expect(
    find.byKey(DiscountCardKeys.service),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.userName),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.date),
    findsWidgets,
  );

  // expect(
  //   find.byKey(DiscountCardKeys.category),
  //   findsWidgets,
  // );

  expect(
    find.byKey(DiscountCardKeys.discountTitle),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.discount),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.expiration),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.city),
    findsWidgets,
  );

  await cityListHelper(tester);

  expect(
    find.byKey(DiscountCardKeys.description),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.eligiblity),
    findsWidgets,
  );

  // await cardTextDetailHelper(tester: tester, link: KAppText.email);

  // expect(
  //   find.byKey(DiscountCardKeys.iconComplaint),
  //   containComplaintIcon ? findsWidgets : findsNothing,
  // );

  expect(
    find.byKey(DiscountCardKeys.iconShare),
    findsWidgets,
  );

  await tester.tap(
    find.byKey(DiscountCardKeys.iconShare).first,
    warnIfMissed: false,
  );

  if (Config.isUser) {
    await popupMenuButtonHelper(
      tester: tester,
      buttonListKeys: [
        DiscountCardKeys.iconComplaint,
        DiscountCardKeys.iconWebsite,
      ],
      buttonKey: DiscountCardKeys.popupMenuButton,
    );
  } else {
    expect(find.byKey(DiscountCardKeys.iconWebsite), findsWidgets);
  }

  // expect(
  //   find.byKey(DiscountCardKeys.iconComplaint),
  //   containComplaintIcon ? findsWidgets : findsNothing,
  // );

  // expect(
  //   find.byKey(DiscountCardKeys.iconWebsite),
  //   findsWidgets,
  // );

  // await tester.tap(
  //   find.byKey(DiscountCardKeys.iconWebsite).first,
  //   warnIfMissed: false,
  // );

  // if (containComplaintIcon) {
  //   await scrollingHelper(
  //     tester: tester,
  //     itemKey: DiscountCardKeys.iconComplaint,
  //   );
  // }
}
