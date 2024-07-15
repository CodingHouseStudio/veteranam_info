import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> discountCardInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountCard.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountCard.closeButton),
    findsWidgets,
  );
}
