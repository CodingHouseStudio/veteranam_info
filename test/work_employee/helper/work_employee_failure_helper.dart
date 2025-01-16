import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workEmployeeFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(InformationKeys.card),
    findsNothing,
  );

  expect(
    find.byKey(WorkEmployeeKeys.buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}
