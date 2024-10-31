import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

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

  await dropChipHelper(
    tester: tester,
    dropChipKey: KWidgetkeys.screen.workEmployee.citiesFilter,
    buttonKey: KWidgetkeys.screen.workEmployee.citiesFilterbuttons,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workEmployee.categoriesFilter),
    findsOneWidget,
  );

  await dropChipHelper(
    tester: tester,
    dropChipKey: KWidgetkeys.screen.workEmployee.categoriesFilter,
    buttonKey: KWidgetkeys.screen.workEmployee.categoriesFilterButtons,
  );
}
