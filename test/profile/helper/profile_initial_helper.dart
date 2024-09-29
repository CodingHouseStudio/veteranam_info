import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.profile.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.subtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.profile.subtitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.profileCard),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.boxSaves),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.boxStory),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.boxFeedback),
        findsOneWidget,
      );

      await profileCardHelper(tester);
    },
  );
}
