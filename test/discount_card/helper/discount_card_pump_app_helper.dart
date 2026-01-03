import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/discount_card/view/diiscount_card_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountCardPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    DiscountCardDialog(
      id: KTestVariables.discountModelItems.first.id,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(DiscountCardDialogKeys.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
