import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddDescriptionEnterHelper({
  required WidgetTester tester,
  required String descriptionText,
  required String exclusionsText,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.descriptionField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.descriptionField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.descriptionField),
    descriptionText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.exclusionField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.exclusionField,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.exclusionField),
    exclusionsText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}
