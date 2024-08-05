import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountCardInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    scrollUp: false,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.discountCard.widget),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountCard.closeButton),
        findsWidgets,
      );

      await discountCardHelper(tester);
    },
  );
}
