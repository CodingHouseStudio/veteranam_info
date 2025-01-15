import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountBackButtonHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool cardIsEmpty,
}) async {
  if (cardIsEmpty) {
    await scrollingHelper(
      tester: tester,
      itemKey: DiscountKeys.invalidLinkBackButton,
    );

    expect(
      find.byKey(DiscountKeys.invalidLinkBackButton),
      findsWidgets,
    );

    await tester.tap(find.byKey(DiscountKeys.invalidLinkBackButton));
  } else {
    await scrollingHelper(
      tester: tester,
      itemKey: DiscountKeys.backButton,
    );

    expect(
      find.byKey(DiscountKeys.backButton),
      findsWidgets,
    );

    await tester.tap(find.byKey(DiscountKeys.backButton));
  }

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.discounts.name),
  ).called(1);
}
