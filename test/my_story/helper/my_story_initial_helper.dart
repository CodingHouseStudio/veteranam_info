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
        find.byKey(MyStoryKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(MyStoryKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(MyStoryKeys.card),
        findsWidgets,
      );

      await storyCardHelper(tester: tester);
    },
  );
}
