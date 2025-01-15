import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyAddInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(StoryAddKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.storyText),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.storyField),
        findsOneWidget,
      );

      await messageFieldHelper(
        tester: tester,
        message: KTestVariables.field,
      );

      expect(
        find.byKey(StoryAddKeys.photoText),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.photoDesciption),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.photoButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: StoryAddKeys.photoButton,
      );

      expect(
        find.byKey(StoryAddKeys.switchAnonymously),
        findsOneWidget,
      );

      await switchHelper(tester: tester);

      expect(
        find.byKey(StoryAddKeys.switchText),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.switchDescription),
        findsOneWidget,
      );

      expect(
        find.byKey(StoryAddKeys.button),
        findsOneWidget,
      );
    },
  );
}
