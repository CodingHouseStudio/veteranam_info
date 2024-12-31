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
      itemKey: KWidgetkeys.screen.discount.invalidLinkBackButton,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discount.invalidLinkBackButton),
      findsWidgets,
    );

    await tester
        .tap(find.byKey(KWidgetkeys.screen.discount.invalidLinkBackButton));
  } else {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.screen.discount.backButton,
    );

    expect(
      find.byKey(KWidgetkeys.screen.discount.backButton),
      findsWidgets,
    );

    await tester.tap(find.byKey(KWidgetkeys.screen.discount.backButton));
  }

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.discounts.name),
  ).called(1);
}
