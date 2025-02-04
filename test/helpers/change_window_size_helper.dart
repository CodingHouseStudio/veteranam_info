import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/constants_flutter.dart';

import '../test_dependency.dart';

/// COMMENT: Helpers change window size in tests
/// (Default value for setDefaultSize is false)
///
/// setDefaultSize if true sets screen size to initial screen size if false
/// tablet size
Future<void> changeWindowSizeHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
  // Size? size,
  bool windowsTest = false,
  bool scrollUp = true,
}) async {
  tester.view.devicePixelRatio = 3.0;
  tester.view.physicalSize = KTestConstants.windowDeskSize * 3;

  await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

  appVersionController.add(AppVersionEnum.desk);

  await tester.pumpAndSettle();

  await test();

  appVersionController.add(AppVersionEnum.mobile);

  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = KTestConstants.windowDefaultSize;

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
