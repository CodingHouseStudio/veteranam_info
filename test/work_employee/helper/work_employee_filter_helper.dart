import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workEmployeeFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.workEmployee.filter), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.resetFilter),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.citiesFilter),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.categoriesFilter),
    findsOneWidget,
  );

  await dropChipHelper(tester);
}
