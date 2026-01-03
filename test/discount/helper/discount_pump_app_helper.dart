import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/discount/view/discount_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountPumpAppHelper(
  WidgetTester tester, {
  String? discountId = KTestVariables.id,
  DiscountModel? discount,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    DiscountScreen(
      discountId: discountId,
      discount: discount,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(DiscountKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
