import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> addDiscountsNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(MyDiscountsKeys.iconAdd),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MyDiscountsKeys.iconAdd,
  );

  await tester.tap(find.byKey(MyDiscountsKeys.iconAdd));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.discountsAdd.name),
  ).called(1);
}
