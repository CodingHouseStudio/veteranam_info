import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobNavigationButtonsHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(MobNavigationKeys.discounts),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: MobNavigationKeys.discounts,
  );

  await tester.tap(find.byKey(MobNavigationKeys.discounts));

  // verify(() => mockGoRouter.goNamed(KRoute.discounts.name)).called(1);

  expect(
    find.byKey(MobNavigationKeys.investors),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobNavigationKeys.investors));

  // verify(() => mockGoRouter.goNamed(KRoute.investors.name)).called(1);

  expect(find.byKey(MobNavigationKeys.settings), findsOneWidget);

  await tester.tap(find.byKey(MobNavigationKeys.settings));

  // verify(() => mockGoRouter.goNamed(KRoute.home.name)).called(1);
}
