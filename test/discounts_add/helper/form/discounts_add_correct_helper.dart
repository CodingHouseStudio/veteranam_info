import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> discountsAddCorectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await discountsAddMainEnterHelper(
    tester: tester,
    categoryText: KTestText.sendDiscountModel.category.first,
    cityText: KTestText.sendDiscountModel.location!.first,
    periodText: KTestText.sendDiscountModel.expiration!,
  );

  await discountsAddMainHelper(tester: tester, hasField: false);

  await discountsAddDetailEnterHelper(
    tester: tester,
    titleText: KTestText.sendDiscountModel.title,
    linkText: KTestText.sendDiscountModel.link,
    discountsText: KTestText.sendDiscountModel.discount.first.toString(),
  );

  await discountsAddDetailHelper(tester: tester, hasField: false);

  await discountsAddDescriptionEnterHelper(
    tester: tester,
    descriptionText: KTestText.sendDiscountModel.description,
    exclusionsText: KTestText.sendDiscountModel.exclusions!,
  );

  verify(
    () => mockGoRouter.goNamed(KRoute.myDiscounts.name),
  ).called(1);
}