import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

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

          await tester
              .tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

          await tester.pumpAndSettle();
        }
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

    await tester.tap(find.byKey(KWidgetkeys.widget.scaffold.loadingButton));

    await tester.pumpAndSettle();

    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
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
