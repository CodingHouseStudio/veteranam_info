import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> workEmployeeFilterHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(WorkEmployeeKeys.filter), findsOneWidget);

  expect(
    find.byKey(WorkEmployeeKeys.resetFilter),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkEmployeeKeys.citiesFilter),
    findsOneWidget,
  );

  await dropChipHelper(
    tester: tester,
    dropChipKey: WorkEmployeeKeys.citiesFilter,
    buttonKey: WorkEmployeeKeys.citiesFilterbuttons,
  );

  expect(
    find.byKey(WorkEmployeeKeys.categoriesFilter),
    findsOneWidget,
  );

  await dropChipHelper(
    tester: tester,
    dropChipKey: WorkEmployeeKeys.categoriesFilter,
    buttonKey: WorkEmployeeKeys.categoriesFilterButtons,
  );
}
