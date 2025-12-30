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
    tester.view.physicalSize =
        KTestConstants.windowDeskSize * tester.view.devicePixelRatio;

    await tester.binding.setSurfaceSize(KTestConstants.windowDeskSize);

    appVersionController.add(AppVersionEnum.desk);
    appVersion = AppVersionEnum.desk;

    await tester.pumpAndSettle();

    await test();

    appVersionController.add(AppVersionEnum.tablet);
    appVersion = AppVersionEnum.tablet;

    tester.view.physicalSize =
        KTestConstants.windowDefaultSize * tester.view.devicePixelRatio;

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
    appVersion = AppVersionEnum.mobile;

    tester.view.physicalSize =
        KTestConstants.windowMobileSize * tester.view.devicePixelRatio;

    await tester.binding.setSurfaceSize(KTestConstants.windowMobileSize);

    await tester.pumpAndSettle();

    await test();

    appVersionController.add(AppVersionEnum.tablet);
    appVersion = AppVersionEnum.tablet;
    await tester.binding.setSurfaceSize(null);

    await tester.pumpAndSettle();
  }
}
