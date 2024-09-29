import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

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
    find.byKey(KWidgetkeys.screen.businessDashboard.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
