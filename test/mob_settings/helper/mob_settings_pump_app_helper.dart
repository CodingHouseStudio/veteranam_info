import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const MobSettingsScreen(),
    mockGoRouter: mockGoRouter,
    addFeedback: true,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
