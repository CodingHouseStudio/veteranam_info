import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddUncorectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await discountsAddMainEnterHelper(
    tester: tester,
    titleText: KTestVariables.fieldEmpty,
    linkText: KTestVariables.sendDiscountModel.discount.first.toString(),
    discountsText: KTestVariables.sendDiscountModel.link!,
    eligibilityTap: false,
  );

  await discountsAddMainHelper(tester: tester);

  await multiDropFieldRemoveHelper(tester);

  await discountsAddMainEnterHelper(
    tester: tester,
    titleText: KTestVariables.sendDiscountModel.title.uk,
    linkText: KTestVariables.sendDiscountModel.directLink!,
    discountsText: KTestVariables.sendDiscountModel.discount.first.toString(),
    eligibilityTap: true,
    // periodText: KTestText.sendDiscountModel.expiration!,
  );

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddDetailHelper(tester: tester, checkHelper: true);

  await discountsAddDetailEnterHelper(
    tester: tester,
    categoryText: KTestVariables.fieldEmpty,
    cityText: KTestVariables.fieldEmpty,
    // periodText: KTestText.fieldEmpty,
    tapOnperiod: false,
    tapIndefinitely: true,
  );

  await discountsAddDetailHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.cityField,
    offset: KTestConstants.scrollingUp,
  );

  await tester.enterText(
    find.byKey(DiscountsAddKeys.cityField),
    KTestVariables.field,
  );

  await discountsAddDetailEnterHelper(
    tester: tester,
    categoryText: KTestVariables.sendDiscountModel.category.first.uk,
    cityText: KTestVariables.sendDiscountModel.location!.first.uk,
  );

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddDescriptionEnterHelper(
    tester: tester,
    descriptionText: KTestVariables.fieldEmpty,
    requirmentsText: KTestVariables.fieldEmpty,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  );

  await discountsAddDescriptionHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.cancelButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(DiscountsAddKeys.cancelButton));

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await discountsAddDetailHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.cancelButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(DiscountsAddKeys.cancelButton));

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await discountsAddMainHelper(tester: tester);
}
