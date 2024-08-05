import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veteranam/shared/shared.dart';

import 'constants.dart';
import 'helpers/helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(getIt.reset);

  testWidgets('Navigation test', (tester) async {
    await tester.pumpApp(tester, routeName: null);

    await homeInitialHelper(tester);

    for (var i = 0; i < KWidgetkeys.widget.footer.buttonsKey.length; i++) {
      // if (i == 5) {
      // await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.logo));

      // ignore: inference_failure_on_instance_creation
      // await Future.delayed(const Duration(milliseconds: 500));

      // await tester.pumpAndSettle();
      // }

      await footerButtonHelper(
        tester: tester,
        buttonKey: KWidgetkeys.widget.footer.buttonsKey.elementAt(i),
      );

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

      await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

      await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.logo));

      await tester.pumpAndSettle();
    }
  });
}
