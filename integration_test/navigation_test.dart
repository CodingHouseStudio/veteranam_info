import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/helper/helper.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(getIt.reset);

  testWidgets('Navigation test', (tester) async {
    await tester.pumpApp(tester, routeName: null);

    if (Config.isWeb) {
      await homeInitialHelper(tester);
    } else {
      await discountsInitialHelper(tester);
    }
    final buttonsKey = Config.isWeb
        ? Config.isDevelopment
            ? FooterKeys.buttonsKey
            : FooterKeys.buttonsProdKey
        : MobNavigationKeys.navButtonsKey.sublist(1);

    for (var i = 0; i < buttonsKey.length; i++) {
      // if (i == 5) {
      // await tester.tap(find.byKey(NawbarKeys.logo));

      // await Future.delayed(const Duration(milliseconds: 500));

      // await tester.pumpAndSettle();
      // }
      if (Config.isWeb) {
        await footerButtonHelper(
          tester: tester,
          buttonKey: buttonsKey.elementAt(i),
        );
        if (Config.isDevelopment) {
          switch (i) {
            case 0:
              await aboutUsInitialHelper(tester);
            case 1:
              await investorsInitialHelper(tester);
            case 2:
              await storyInitialHelper(tester);
            case 3:
              await discountsInitialHelper(tester);
            case 4:
              await loginInitialHelper(tester);
            case 5:
              await workInitialHelper(tester);
            case 6:
              await informationInitialHelper(tester);
          }
        } else {
          switch (i) {
            case 0:
              await investorsInitialHelper(tester);
            case 1:
              await discountsInitialHelper(tester);
          }
        }
        await scrollingHelperInt(
          tester: tester,
          offset: KTestConstants.scrollingUp,
        );

        await tester.tap(find.byKey(NawbarKeys.logo));

        await tester.pumpAndSettle();
      } else {
        await mobNavigationButtonHelper(
          tester: tester,
          buttonKey: buttonsKey.elementAt(i),
        );

        switch (i) {
          case 0:
            await investorsInitialHelper(tester);
          case 1:
            await mobSettingsInitialHelper(tester);
        }
      }
    }
  });
}
