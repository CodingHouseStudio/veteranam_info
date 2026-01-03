import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/work_employee/view/work_employee_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workEmployeePumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const WorkEmployeeScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(WorkEmployeeKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
