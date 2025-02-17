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
    titleText: KTestVariables.sendDiscountModel.title.uk,
    linkText: KTestVariables.sendDiscountModel.directLink!,
    discountsText: KTestVariables.sendDiscountModel.discount.first.toString(),
    eligibilityTap: true, isEdit: isEdit,
    // periodText: KTestVariables.sendDiscountModel.expiration!,
  );

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddDetailEnterHelper(
    tester: tester,
    categoryText: KTestVariables.sendDiscountModel.category.first.uk,
    cityText: KTestVariables.sendDiscountModel.location!.first.uk,
    tapIndefinitely: !isEdit,
  );

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddDescriptionEnterHelper(
    tester: tester,
    descriptionText: KTestVariables.sendDiscountModel.description.uk,
    requirmentsText: KTestVariables.sendDiscountModel.requirements!.uk,
    emailText: KTestVariables.userEmail,
  );

  if (!isEdit) {
    await confirmPublishDiscountDialogNavHelper(
      tester: tester,
      mockGoRouter: mockGoRouter,
      openEvent: () async => discountsAddSendHelper(tester),
    );
  }
  expect(
    find.byKey(DiscountsAddKeys.submitingText),
    findsOneWidget,
  );

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}
