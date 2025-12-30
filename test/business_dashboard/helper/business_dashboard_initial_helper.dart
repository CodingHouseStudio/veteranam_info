import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> businessDashboardInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(BusinessDashboardKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(BusinessDashboardKeys.subtitle),
        findsOneWidget,
      );
      expect(
        find.byKey(BusinessDashboardKeys.myProfielBox),
        findsOneWidget,
      );

      expect(
        find.byKey(BusinessDashboardKeys.myDiscountsBox),
        findsOneWidget,
      );
    },
  );
}
