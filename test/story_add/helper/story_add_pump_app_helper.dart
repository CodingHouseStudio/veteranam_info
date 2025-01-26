import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/story_add/view/story_add_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyAddPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const StoryAddScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(StoryAddKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}
