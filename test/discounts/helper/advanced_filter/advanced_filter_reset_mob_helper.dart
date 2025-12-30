import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> advancedFilterResetMobHelper(
  WidgetTester tester,
) async {
  final isMobile =
      tester.widgetList(find.byKey(DiscountsFilterKeys.mob)).isNotEmpty;

  await scrollingHelper(
    tester: tester,
    itemKey: isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
  );

  expect(
    find.byKey(
      isMobile ? DiscountsFilterKeys.mob : DiscountsFilterKeys.desk,
    ),
    findsOneWidget,
  );

  expect(
    find.byKey(DiscountsFilterKeys.mobButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(DiscountsFilterKeys.mobButton));

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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    scrollKey: DiscountsFilterKeys.list,
  );

  expect(
    find.byKey(DiscountsFilterKeys.cancelChip),
    findsWidgets,
  );

  expect(
    find.byKey(DiscountsFilterKeys.resetButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(DiscountsFilterKeys.resetButton),
  );

  await tester.pumpAndSettle();

  // expect(
  //   find.byKey(DiscountsFilterKeys.cancelChip),
  //   findsNothing,
  // );

  // verify(() => mockGoRouter.pop()).called(1);
}
