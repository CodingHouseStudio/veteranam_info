import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/discounts/view/discounts_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> discountsPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const DiscountsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(DiscountsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
