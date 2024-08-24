import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> privacyPolicyNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.bugButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.privacyPolicy),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.privacyPolicy,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.privacyPolicy));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.privacyPolicy.name),
  ).called(1);
}
