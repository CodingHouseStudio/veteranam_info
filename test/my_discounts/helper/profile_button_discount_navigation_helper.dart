import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> profileButtonDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.myDiscounts.buttonProfile),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.myDiscounts.buttonProfile,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.myDiscounts.buttonProfile));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.company.name),
  ).called(1);
}
