import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddDescriptionEnterHelper({
  required WidgetTester tester,
  required String descriptionText,
  required String requirmentsText,
}) async {
  expect(
    find.byKey(DiscountsAddKeys.descriptionField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.descriptionField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.descriptionField),
    descriptionText,
  );

  await tester.pumpAndSettle();

  expect(
    find.byKey(DiscountsAddKeys.exclusionField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.exclusionField,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.exclusionField),
    requirmentsText,
  );

  await tester.pumpAndSettle();

  await discountsAddSendHelper(tester);
}
