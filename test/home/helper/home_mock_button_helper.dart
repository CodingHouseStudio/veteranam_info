import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

// import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

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
      //   itemKey: HomeKeys.buttonMock,
      // );

      // await mockButtonHelper(
      //   tester: tester,
      //   card: HomeKeys.faq,
      //   buttonMock: HomeKeys.buttonMock,
      // );
    },
  );
}
