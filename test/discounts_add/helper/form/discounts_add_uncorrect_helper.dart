import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddUncorectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await discountsAddMainEnterHelper(
    tester: tester,
    categoryText: KTestText.fieldEmpty,
    cityText: KTestText.fieldEmpty,
    periodText: KTestText.fieldEmpty,
  );

  await discountsAddMainHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cityField,
    offset: KTestConstants.scrollingUp,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.screen.discountsAdd.cityField),
    KTestText.field,
  );

  await discountsAddMainEnterHelper(
    tester: tester,
    categoryText: KTestText.sendDiscountModel.category.first,
    cityText: KTestText.sendDiscountModel.location!.first,
    periodText: KTestText.sendDiscountModel.expiration!,
  );

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddDetailEnterHelper(
    tester: tester,
    titleText: KTestText.fieldEmpty,
    linkText: KTestText.sendDiscountModel.discount.first.toString(),
    discountsText: KTestText.sendDiscountModel.link,
  );

  await discountsAddDetailHelper(tester: tester);

  await discountsAddDetailEnterHelper(
    tester: tester,
    titleText: KTestText.sendDiscountModel.title,
    linkText: KTestText.sendDiscountModel.link,
    discountsText: KTestText.sendDiscountModel.discount.first.toString(),
  );

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddDescriptionEnterHelper(
    tester: tester,
    descriptionText: KTestText.fieldEmpty,
    exclusionsText: KTestText.fieldEmpty,
  );

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  );

  await discountsAddDescriptionHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cancelButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton));

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await discountsAddDetailHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cancelButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton));

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  await discountsAddMainHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.cancelButton,
    offset: KTestConstants.scrollingDown,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.cancelButton));

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  );
}
