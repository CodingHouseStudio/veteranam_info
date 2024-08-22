import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> userEmailScrollHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
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

      // await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

      // await tester.pumpAndSettle();

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingDown,
      // );

      // await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

      // await tester.pumpAndSettle();

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingDown,
      // );

      await test(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );
    },
  );
}
