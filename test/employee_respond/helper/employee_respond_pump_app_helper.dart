import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/employee_respond/view/employee_respond_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> employeeRespondPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const EmployeeRespondScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(EmployeeRespondKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
