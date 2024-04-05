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
    await homeHelper(tester);

    await footerHelper(
      tester: tester,
      email: KTestText.useremail,
    );

    for (var i = 0; i < KWidgetkeys.widget.footer.buttonsKey.length; i++) {
      for (var j = 0;
          j < KWidgetkeys.widget.footer.buttonsKey.elementAt(i).length;
          j++) {
        final buttonKey =
            KWidgetkeys.widget.footer.buttonsKey.elementAt(i).elementAt(j);
        final screenKey = KTestConstants.screens.elementAt(i).elementAt(j);

        await scrollingHelper(
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
    }
  });
}
