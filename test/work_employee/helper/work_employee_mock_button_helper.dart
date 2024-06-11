import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workEmployeeMockButtonHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.workEmployee.buttonMock,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.buttonMock),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.workEmployee.buttonMock));
}
