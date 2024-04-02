import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.workCardKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.city), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.employer), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.iconSafe), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.iconShare), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.price), findsOneWidget);

  expect(find.byKey(KWidgetkeys.workCardKeys.button), findsOneWidget);

  await cardTextDetailHelper(tester);
}
