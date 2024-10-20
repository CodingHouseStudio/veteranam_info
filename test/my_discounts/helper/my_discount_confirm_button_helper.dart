import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> myDiscountConfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await myDiscountDialogHelper(tester);

  await tester.pumpAndSettle(const Duration(seconds: 15));

  await dialogConfirmHelper(
    tester: tester,
    mockGoRouter: mockGoRouter,
  );
}
