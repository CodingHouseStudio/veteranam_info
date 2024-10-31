import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/profile_saves/view/view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> profileSavesPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const ProfileSavesScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.profileSaves.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
