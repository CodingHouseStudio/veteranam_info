import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/mob_settings/view/mob_settings_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> mobSettingsPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const MobSettingsScreen(),
    mockGoRouter: mockGoRouter,
    addFeedback: true,
  );

  expect(
    find.byKey(MobSettingsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
