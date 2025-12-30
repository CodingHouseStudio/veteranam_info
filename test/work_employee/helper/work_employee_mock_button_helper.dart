import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> workEmployeeMockButtonHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(InformationKeys.card),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: WorkEmployeeKeys.buttonMock,
  );

  expect(
    find.byKey(WorkEmployeeKeys.buttonMock),
    findsOneWidget,
  );

  await tester.tap(find.byKey(WorkEmployeeKeys.buttonMock));
}
