import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> profilePumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const ProfileScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(ProfileKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
