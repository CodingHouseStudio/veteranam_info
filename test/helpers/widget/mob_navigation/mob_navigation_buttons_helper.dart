import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> mobNavigationButtonsHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.discounts),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.discounts));

  verify(() => mockGoRouter.goNamed(KRoute.discounts.name)).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.investors),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.investors));

  verify(() => mockGoRouter.goNamed(KRoute.investors.name)).called(1);

  expect(find.byKey(KWidgetkeys.widget.mobNavigation.settings), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.mobNavigation.settings));

  verify(() => mockGoRouter.goNamed(KRoute.home.name)).called(1);
}
