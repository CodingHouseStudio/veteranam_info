import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(WorkCardKeys.title), findsOneWidget);

  expect(find.byKey(WorkCardKeys.city), findsOneWidget);

  expect(
    find.byKey(WorkCardKeys.employer),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkCardKeys.iconSafe),
    findsOneWidget,
  );

  expect(
    find.byKey(WorkCardKeys.iconShare),
    findsOneWidget,
  );

  expect(find.byKey(WorkCardKeys.price), findsOneWidget);

  expect(
    find.byKey(WorkCardKeys.button),
    findsOneWidget,
  );

  await cardTextDetailHelper(tester);
}
