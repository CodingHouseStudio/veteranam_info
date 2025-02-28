import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../../test_dependency.dart';

Future<void> discountCardNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(DiscountCardKeys.cityMoreButton),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountCardKeys.cityMoreButton,
  );

  await tester.tap(find.byKey(DiscountCardKeys.cityMoreButton).first);

  verify(
    () => mockGoRouter.goNamed(
      KRoute.discount.name,
      pathParameters: {
        UrlParameters.cardId: KTestVariables.moreDiscountModel.id,
      },
      extra: KTestVariables.moreDiscountModel,
    ),
  ).called(1);

  expect(
    find.byKey(DiscountCardKeys.eligiblityMoreButton),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountCardKeys.eligiblityMoreButton,
  );

  await tester.tap(find.byKey(DiscountCardKeys.eligiblityMoreButton).first);

  verify(
    () => mockGoRouter.goNamed(
      KRoute.discount.name,
      pathParameters: {
        UrlParameters.cardId: KTestVariables.moreDiscountModel.id,
      },
      extra: KTestVariables.moreDiscountModel,
    ),
  ).called(1);

  expect(
    find.byKey(DiscountCardKeys.button),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: DiscountCardKeys.button,
  );

  await tester.tap(find.byKey(DiscountCardKeys.button).first);

  verify(
    () => mockGoRouter.goNamed(
      KRoute.discount.name,
      pathParameters: {
        UrlParameters.cardId: KTestVariables.moreDiscountModel.id,
      },
      extra: KTestVariables.moreDiscountModel,
    ),
  ).called(1);
}
