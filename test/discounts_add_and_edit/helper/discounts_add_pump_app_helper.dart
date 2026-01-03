import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/discounts_add/view/discounts_add_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountsAddPumpAppHelper(
  WidgetTester tester, {
  DiscountModel? discount,
  String? discountId,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    DiscountsAddScreen(
      discount: discount,
      discountId: discountId,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(DiscountsAddKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
