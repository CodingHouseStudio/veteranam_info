import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> notificationLinkScrollHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
  bool scrollUp = false,
  bool windowsTest = false,
  Key? itemKey,
}) async {
  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingUp500,
  // );

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: windowsTest,
    test: () async {
      await tester.dragUntilVisible(
        find.byKey(itemKey ?? KWidgetkeys.widget.notificationLink.text),
        find.byKey(KWidgetkeys.widget.scaffold.scroll),
        KTestConstants.scrollingDown100,
        maxIteration: 1000,
      );

      await tester.pumpAndSettle();

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp200,
      // );

      await test(tester);
    },
  );
  if (scrollUp) {
    await tester.dragUntilVisible(
      find.byKey(
        KWidgetkeys.screen.discounts.title,
      ),
      find.byKey(KWidgetkeys.widget.scaffold.scroll),
      KTestConstants.scrollingUp,
    );
  }
}
