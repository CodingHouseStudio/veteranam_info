import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> logOutConfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await tester.pumpAndSettle();

  await companyLogOutHelper(tester);

  await confirmDialogHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
    isPop: false,
  );
}
