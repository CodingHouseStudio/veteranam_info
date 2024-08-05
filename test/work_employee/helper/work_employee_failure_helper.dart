import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> workEmployeeFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}
