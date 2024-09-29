import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> businessDashboardInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.businessDashboard.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.businessDashboard.subtitle),
        findsOneWidget,
      );
      expect(
        find.byKey(KWidgetkeys.screen.businessDashboard.myProfielBox),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.businessDashboard.myDiscountsBox),
        findsOneWidget,
      );
    },
  );
}
