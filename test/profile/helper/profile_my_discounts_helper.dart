import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> profileMyDiscountsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.boxMyDiscounts),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.profile.boxMyDiscounts,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.profile.boxMyDiscounts));

  verify(() => mockGoRouter.goNamed(KRoute.myDiscounts.name)).called(1);
}
