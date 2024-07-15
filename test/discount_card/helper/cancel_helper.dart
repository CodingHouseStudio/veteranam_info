import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    scrollKey: KWidgetkeys.screen.discountCard.dialog,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountCard.closeButton),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountCard.closeButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.discounts.name),
  ).called(1);
}
