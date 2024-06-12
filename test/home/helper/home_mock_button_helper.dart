import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> homeMockButtonHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp1000,
        itemKey: KWidgetkeys.screen.home.buttonMock,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.faq),
        findsNothing,
      );

      await dialogFailureGetHelper(tester: tester, isFailure: false);

      expect(
        find.byKey(KWidgetkeys.screen.home.buttonMock),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.buttonMock));
    },
  );
}
