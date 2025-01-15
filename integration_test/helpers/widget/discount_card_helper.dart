import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> discountCardHelper(
  WidgetTester tester,
) async {
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
    findsNothing,
  );

  // expect(
  //   find.byKey(DiscountCardKeys.description),
  //   findsWidgets,
  // );

  expect(
    find.byKey(DiscountCardKeys.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.iconShare),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.iconComplaint),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountCardKeys.iconWebsite),
    findsWidgets,
  );
}
