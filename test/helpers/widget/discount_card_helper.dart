import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

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
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.discountCard.description),
    findsWidgets,
  );
  expect(
    find.byKey(KWidgetkeys.widget.discountCard.buttons),
    findsWidgets,
  );
}
