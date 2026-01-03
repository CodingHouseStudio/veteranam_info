import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> fieldCorrectHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(StoryAddKeys.storyField), findsOneWidget);

  await messageFieldHelper(
    tester: tester,
    message: KTestVariables.storyModelItems.first.story,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: StoryAddKeys.photoButton,
  );

  await tester.tap(find.byKey(StoryAddKeys.photoButton));

  await scrollingHelper(
    tester: tester,
    itemKey: StoryAddKeys.button,
  );

  await tester.tap(find.byKey(StoryAddKeys.button));

  await tester.pumpAndSettle();
}
