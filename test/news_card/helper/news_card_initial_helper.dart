import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../helpers/helpers.dart';

Future<void> newsCardInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    windowsTest: true,
    scrollUp: false,
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.newsCard.widget),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.newsCard.closeButton),
        findsWidgets,
      );
      await newsCardHelper(tester: tester);
    },
  );
}
