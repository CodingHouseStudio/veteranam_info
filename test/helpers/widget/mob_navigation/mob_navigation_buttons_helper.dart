import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> mobNavigationButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(MobNavigationKeys.discounts),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobNavigationKeys.discounts));

  verify(() => mockGoRouter.goNamed(KRoute.discounts.name)).called(1);

  expect(
    find.byKey(MobNavigationKeys.investors),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobNavigationKeys.investors));

  verify(() => mockGoRouter.goNamed(KRoute.support.name)).called(1);

  expect(find.byKey(MobNavigationKeys.settings), findsOneWidget);

  await tester.tap(find.byKey(MobNavigationKeys.settings));

  verify(() => mockGoRouter.goNamed(KRoute.settings.name)).called(1);
}
