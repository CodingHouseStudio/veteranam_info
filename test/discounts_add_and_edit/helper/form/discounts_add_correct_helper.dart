import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddCorectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  bool isEdit = false,
}) async {
  await discountsAddMainEnterHelper(
    tester: tester,
    titleText: KTestText.sendDiscountModel.title.uk,
    linkText: KTestText.sendDiscountModel.directLink!,
    discountsText: KTestText.sendDiscountModel.discount.first.toString(),
    eligibilityTap: true, isEdit: isEdit,
    // periodText: KTestText.sendDiscountModel.expiration!,
  );

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddDetailEnterHelper(
    tester: tester,
    categoryText: KTestText.sendDiscountModel.category.first.uk,
    cityText: KTestText.sendDiscountModel.location!.first.uk,
    tapIndefinitely: !isEdit,
  );

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddDescriptionEnterHelper(
    tester: tester,
    descriptionText: KTestText.sendDiscountModel.description.uk,
    exclusionsText: KTestText.sendDiscountModel.exclusions!.uk,
  );

  if (!isEdit) {
    await confirmPublishDiscountDialogNavHelper(
      tester: tester,
      mockGoRouter: mockGoRouter,
    );
  }
  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.submitingText),
    findsOneWidget,
  );

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}