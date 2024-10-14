import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsEmptyProfilePageHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.iconAdd),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.emptyProfileText),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.myDiscounts.buttonProfile),
        findsWidgets,
      );
    },
  );
}
