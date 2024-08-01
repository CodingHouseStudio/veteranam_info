import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.phoneNumberField,
  );

  expect(
    find.byKey(KWidgetkeys.screen.employeeRespond.cancelButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.employeeRespond.cancelButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.employeeRespond.cancelButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.workEmployee.name),
  ).called(1);
}
