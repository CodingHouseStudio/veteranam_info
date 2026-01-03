import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: DiscountCardDialogKeys.closeButton,
  );

  expect(
    find.byKey(DiscountCardDialogKeys.closeButton),
    findsWidgets,
  );

  await tester.tap(find.byKey(DiscountCardDialogKeys.closeButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.discounts.name),
  ).called(1);
}
