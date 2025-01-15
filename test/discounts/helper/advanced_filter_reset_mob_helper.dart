import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> advancedFilterResetMobHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsKeys.advancedFilterMob)).isNotEmpty;

  await scrollingHelper(
    tester: tester,
    itemKey: isMobile
        ? DiscountsKeys.advancedFilterMob
        : DiscountsKeys.advancedFilterDesk,
  );

  expect(
    find.byKey(
      isMobile
          ? DiscountsKeys.advancedFilterMob
          : DiscountsKeys.advancedFilterDesk,
    ),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsKeys.advancedFilterButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsKeys.advancedFilterButton));

  await tester.pumpAndSettle();

  await chekPointSignleTapHelper(
    tester: tester,
    hasAmount: true,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    index: 3,
    hasAmount: true,
  );

  await chekPointSignleTapHelper(
    tester: tester,
    index: 2,
    hasAmount: true,
  );

  expect(
    find.byKey(DiscountsKeys.appliedFilterItems),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsKeys.advancedFilterResetButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(DiscountsKeys.advancedFilterResetButton),
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(DiscountsKeys.appliedFilterItems),
  //   findsNothing,
  // );

  verify(() => mockGoRouter.pop()).called(1);
}
