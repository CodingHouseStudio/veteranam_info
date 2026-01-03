import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> privacyPolicyNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.feedbackButton,
  );

  expect(
    find.byKey(MobSettingsKeys.privacyPolicy),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.privacyPolicy,
  );

  await tester.tap(find.byKey(MobSettingsKeys.privacyPolicy));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.privacyPolicy.name),
  ).called(1);
}
