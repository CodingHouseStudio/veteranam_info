import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/work_employer/view/employer_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> employerPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const WorkEmployerScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.employer.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
