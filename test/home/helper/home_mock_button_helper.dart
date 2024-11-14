import 'package:flutter_test/flutter_test.dart';
// import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

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

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp1000,
      //   itemKey: KWidgetkeys.screen.home.buttonMock,
      // );

      // await mockButtonHelper(
      //   tester: tester,
      //   card: KWidgetkeys.screen.home.faq,
      //   buttonMock: KWidgetkeys.screen.home.buttonMock,
      // );
    },
  );
}
