import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/enum.dart';

import '../../test_dependency.dart';

Future<void> homeChangeWindowSizeHelper({
  required WidgetTester tester,
  required Future<void> Function() test,
  bool isMobile = false,
  bool isDesk = true,
  bool tabletTest = false,
}) async {
  if (isDesk) {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = KTestConstants.windowDeskSize;

    await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

    appVersionController.add(AppVersionEnum.desk);

    await tester.pumpAndSettle();

    await test();

    appVersionController.add(AppVersionEnum.tablet);

    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = KTestConstants.windowDefaultSize;

    await tester.binding.setSurfaceSize(null);

    await tester.pumpAndSettle();
  }

  if (tabletTest) {
    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    await test();
  }
  if (isMobile) {
    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    appVersionController.add(AppVersionEnum.mobile);

    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = KTestConstants.windowMobileSize;

    await tester.binding.setSurfaceSize(KTestConstants.windowMobileSize);

    await tester.pumpAndSettle();

    await test();

    appVersionController.add(AppVersionEnum.tablet);
    await tester.binding.setSurfaceSize(null);

    await tester.pumpAndSettle();
  }
}
