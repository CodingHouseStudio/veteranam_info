import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/business_dashboard/view/business_dashboard_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> businessDashboardPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const BusinessDashboardScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(BusinessDashboardKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
