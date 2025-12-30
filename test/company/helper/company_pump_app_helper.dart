import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/company/view/company_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> companyPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const CompanyScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(CompanyKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
