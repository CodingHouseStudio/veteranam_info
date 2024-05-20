import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> storyInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.story.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.story.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.story.card),
    findsWidgets,
  );

  await storyCardHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.screen.story.buttonMock),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.story.card,
  );

  expect(
    find.byKey(KWidgetkeys.screen.story.button),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.story.buttonIcon),
    findsNothing,
  );

  await changeWindowSizeHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.screen.story.buttonIcon),
    findsOneWidget,
  );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}
