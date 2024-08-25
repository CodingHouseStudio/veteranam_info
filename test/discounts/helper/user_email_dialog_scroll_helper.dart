import 'package:flutter_test/flutter_test.dart';

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

      await scaffoldLoadingButtonHelper(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scaffoldLoadingButtonHelper(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scaffoldLoadingButtonHelper(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await test(tester);

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );
    },
  );
}
