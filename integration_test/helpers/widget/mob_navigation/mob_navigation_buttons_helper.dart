import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobNavigationButtonsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.discounts),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.mobNavigation.discounts,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.discounts));

  // verify(() => mockGoRouter.goNamed(KRoute.discounts.name)).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.investors),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.investors));

  // verify(() => mockGoRouter.goNamed(KRoute.investors.name)).called(1);

  expect(find.byKey(KWidgetkeys.widget.mobNavigation.settings), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.settings));

  // verify(() => mockGoRouter.goNamed(KRoute.home.name)).called(1);
}
