import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/my_story/view/my_story_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> myStoryPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(
    const ProfileMyStoryScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(MyStoryKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
