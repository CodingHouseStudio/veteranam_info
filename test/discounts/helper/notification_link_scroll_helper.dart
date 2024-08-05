import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

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

      await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp200,
      // );

      await test();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );
    },
  );
}
