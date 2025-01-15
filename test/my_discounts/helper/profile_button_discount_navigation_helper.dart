import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> profileButtonDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(MyDiscountsKeys.buttonProfile),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MyDiscountsKeys.buttonProfile,
  );

  await tester.tap(find.byKey(MyDiscountsKeys.buttonProfile));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.company.name),
  ).called(1);
}
