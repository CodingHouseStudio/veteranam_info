import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/story/view/story_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const StoryScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(StoryKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
