import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(WorkCardKeys.title), findsWidgets);

  expect(find.byKey(WorkCardKeys.city), findsWidgets);

  expect(
    find.byKey(WorkCardKeys.employer),
    findsWidgets,
  );

  expect(
    find.byKey(WorkCardKeys.iconSafe),
    findsWidgets,
  );

  expect(
    find.byKey(WorkCardKeys.iconShare),
    findsWidgets,
  );

  expect(find.byKey(WorkCardKeys.price), findsWidgets);

  expect(
    find.byKey(WorkCardKeys.button),
    findsWidgets,
  );

  await cardTextDetailHelper(tester: tester);
}
