import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddDetailEnterHelper({
  required WidgetTester tester,
  required String titleText,
  required String linkText,
  required String discountsText,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.titleField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.titleField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.titleField),
    titleText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.discountsField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.discountsField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.discountsField),
    discountsText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.linkField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.linkField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.linkField),
    linkText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}