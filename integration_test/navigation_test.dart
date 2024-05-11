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

      if (i == 6) {
        await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.logo));

        // ignore: inference_failure_on_instance_creation
        await Future.delayed(const Duration(milliseconds: 500));

        await tester.pumpAndSettle();
      }

      if (screenKey != KWidgetkeys.screen.contact.screen) {
        await scrollingHelperInt(
          tester: tester,
          offset: KTestConstants.scrolling,
          itemKey: buttonKey,
        );
      } else {
        await scrollingHelperInt(
          tester: tester,
          offset: KTestConstants.scrolling,
          itemKey: KWidgetkeys.screen.investors.donateCard,
        );

        await tester.ensureVisible(
          find.byKey(KWidgetkeys.screen.investors.donateCard).last,
        );
        await tester.pumpAndSettle();

        await scrollingHelperInt(
          tester: tester,
          itemKey: KWidgetkeys.widget.footer.widget,
        );
        await scrollingHelperInt(
          tester: tester,
          itemKey: buttonKey,
        );
      }

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
