import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> notificationLinkScrollHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp500,
      );

      await test();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );
    },
  );
}
