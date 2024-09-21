import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddMainEnterHelper({
  required WidgetTester tester,
  required String categoryText,
  required String cityText,
  required String periodText,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.categoryField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.categoryField,
  );

  // await tester.enterText(
  //   find.byKey(KWidgetkeys.screen.discountsAdd.categoryField),
  //   categoryText,
  // );

  await dropListFieldItemHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cityField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    cityText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.periodField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.periodField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.periodField),
    periodText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}
