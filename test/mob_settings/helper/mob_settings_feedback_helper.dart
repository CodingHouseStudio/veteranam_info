import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsFeedbackHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.offlinesSwitcher,
  );

  expect(
    find.byKey(MobSettingsKeys.feedbackButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MobSettingsKeys.feedbackButton,
  );

  await tester.tap(find.byKey(MobSettingsKeys.feedbackButton));

  verify(() => mockGoRouter.goNamed(KRoute.feedback.name)).called(1);
}
