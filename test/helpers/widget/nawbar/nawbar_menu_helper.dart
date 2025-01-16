import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> nawbarMenuHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await openNawbarMenuHelper(tester: tester, mockGoRouter: mockGoRouter);

  await menuDialogHelper(tester: tester, mockGoRouter: mockGoRouter);
}
