import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> storyInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.story.screen), findsOneWidget);

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

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingUp500,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.screen.story.button),
  //   findsOneWidget,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.screen.story.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(KWidgetkeys.screen.story.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}