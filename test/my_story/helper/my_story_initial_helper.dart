import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

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
