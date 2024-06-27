import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> myStoryInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.myStory.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myStory.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myStory.card),
        findsWidgets,
      );

      await storyCardHelper(tester: tester);
    },
  );
}
