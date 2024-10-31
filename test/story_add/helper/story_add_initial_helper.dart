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
        find.byKey(KWidgetkeys.screen.storyAdd.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.storyText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.storyField),
        findsOneWidget,
      );

      await messageFieldHelper(
        tester: tester,
        message: KTestText.field,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.photoText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.photoDesciption),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.photoButton),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.storyAdd.photoButton,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.switchAnonymously),
        findsOneWidget,
      );

      await switchHelper(tester: tester);

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.switchText),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.switchDescription),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.storyAdd.button),
        findsOneWidget,
      );
    },
  );
}
