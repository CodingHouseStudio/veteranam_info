import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.phoneNumberField,
  );

  expect(
    find.byKey(EmployeeRespondKeys.cancelButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: EmployeeRespondKeys.cancelButton,
  );

  await tester.tap(find.byKey(EmployeeRespondKeys.cancelButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.workEmployee.name),
  ).called(1);
}
