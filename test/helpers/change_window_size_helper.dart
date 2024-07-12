import 'package:flutter_test/flutter_test.dart';

import '../text_dependency.dart';

/// COMMENT: Helpers change window size in tests
/// (Default value for setDefaultSize is false)
///
/// setDefaultSize if true sets screen size to initial screen size if false
/// tablet size
Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
  bool windowsTest = false,
  bool scrollUp = true,
}) async {
  await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

  await tester.pumpAndSettle();

  await test();

  await tester.binding.setSurfaceSize(null);

  await tester.pumpAndSettle();

  if (windowsTest) {
    if (scrollUp) {
      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);
    }

    await test();
  }
}

/// FOLDER FILES COMMENT: Files for widgets test or helper for test
