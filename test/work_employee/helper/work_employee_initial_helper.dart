import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> workEmployeeInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.subtitle),
    findsOneWidget,
  );

  await workEmployeeFilterHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.cards),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.mockDataButton),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp500,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.pagination),
    findsOneWidget,
  );

  await paginationTest(tester);
}
