import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> markdownFileDialogInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    size: KTestConstants.windowSmallSize,
    windowsTest: true,
    scrollUp: false,
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.privacyPolicy.text),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon),
        findsOneWidget,
      );

      await tester.tapOnTextCustom(text: KTestVariables.developerEmail);

      await tester.pumpAndSettle();

      // await dialogSnackBarTextHelper(tester: tester);
    },
  );
}
