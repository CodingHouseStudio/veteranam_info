import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(StoryKeys.screen), findsOneWidget);

  expect(
    find.byKey(StoryKeys.title),
    findsOneWidget,
  );

  expect(
    find.byKey(StoryKeys.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(StoryKeys.card),
    findsWidgets,
  );

  await storyCardHelper(tester: tester);

  expect(
    find.byKey(StoryKeys.buttonMock),
    findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingUp500,
  // );

  // expect(
  //   find.byKey(StoryKeys.button),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(StoryKeys.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(StoryKeys.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}
