import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listLoadHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.storyCard.userName), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.story.button,
    // offset: KTestConstants.scrollingUp500,
  );

  expect(find.byKey(KWidgetkeys.screen.story.button), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.screen.story.button));

  await tester.pumpAndSettle();

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(find.byKey(KWidgetkeys.widget.storyCard.userName), findsWidgets);
}
