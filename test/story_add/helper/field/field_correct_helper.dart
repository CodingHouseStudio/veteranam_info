import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> fieldCorrectHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.storyAdd.storyField), findsOneWidget);

  await messageFieldHelper(
    tester: tester,
    message: KTestVariables.storyModelItems.first.story,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.photoButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.storyAdd.photoButton));

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.storyAdd.button));

  await tester.pumpAndSettle();
}
