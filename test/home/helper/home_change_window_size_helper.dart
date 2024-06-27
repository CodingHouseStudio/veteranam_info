import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';

Future<void> homeChangeWindowSizeHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
  bool isMobile = false,
  bool isDesk = true,
  bool tabletTest = false,
}) async {
  if (isDesk) {
    await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

    await tester.pumpAndSettle();

    await test();

    await tester.binding.setSurfaceSize(null);

    await tester.pumpAndSettle();
  }

  if (tabletTest) {
    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    await test();
  }
  if (isMobile) {
    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    await tester.binding.setSurfaceSize(KTestConstants.windowMobileSize);

    await tester.pumpAndSettle();

    await test();

    await tester.binding.setSurfaceSize(null);

    await tester.pumpAndSettle();
  }
}
