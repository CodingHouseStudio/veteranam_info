import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/my_discounts/view/my_discounts_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> myDiscountsPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const MyDiscountsScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(MyDiscountsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
