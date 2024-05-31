import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kozak/shared/shared.dart';

import 'constants.dart';
import 'helper/helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // This is run before all tests
  setUpAll(setUpGlobalIntegration);

  tearDownAll(getIt.reset);

  testWidgets('Navigation test', (tester) async {
    await appHelper(tester);

    await scrollingHelperInt(tester: tester, offset: KTestConstants.scrolling);

    await footerHelper(
      tester: tester,
      email: KTestText.useremail,
    );

    for (var i = 0; i < KWidgetkeys.widget.footer.buttonsKey.length; i++) {
      final buttonKey = KWidgetkeys.widget.footer.buttonsKey.elementAt(i);
      final screenKey = KTestConstants.screens.elementAt(i);

      if (i == 5) {
        await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.logo));

        // ignore: inference_failure_on_instance_creation
        await Future.delayed(const Duration(milliseconds: 500));

        await tester.pumpAndSettle();
      }

      await scrollingHelperInt(
        tester: tester,
        offset: KTestConstants.scrolling,
        itemKey: buttonKey,
      );

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );

      await tester.tap(find.byKey(buttonKey));

      await tester.pumpAndSettle();

      expect(find.byKey(screenKey), findsOneWidget);
    }
  });
}
