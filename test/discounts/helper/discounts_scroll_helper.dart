import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> discountsScrollHelper({
  required WidgetTester tester,
  required Future<void> Function(WidgetTester tester) test,
  bool showEmailDialog = false,
  bool? isDesk,
}) async {
  if (isDesk ?? true) {
    await changeWindowSizeHelper(
      tester: tester,
      test: () async {
        if (showEmailDialog) {
          await scrollingHelper(
            tester: tester,
            offset: KTestConstants.scrollingDown,
          );

          await scaffoldLoadingButtonHelper(
            tester: tester,
            hoverOnButton: true,
          );
        }
        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scaffoldLoadingButtonHelper(tester: tester);

        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );

        await scaffoldLoadingButtonHelper(tester: tester);

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
  } else {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );

    await scaffoldLoadingButtonHelper(tester: tester);

    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );

    await scaffoldLoadingButtonHelper(tester: tester);

    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );

    await test(tester);

    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingUp,
    );
  }
}
