import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> fieldCorrectHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.storyAdd.storyField), findsOneWidget);

  await messageFieldHelper(
    tester: tester,
    message: KTestText.storyModelItems.first.story,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.photoButton,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.storyAdd.button));

  await tester.pumpAndSettle();
}
