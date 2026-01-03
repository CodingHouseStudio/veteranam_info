import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> myDiscountsEmptyPageHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(MyDiscountsKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(MyDiscountsKeys.iconAdd),
        findsOneWidget,
      );

      expect(
        find.byKey(MyDiscountsKeys.iconEmpty),
        findsWidgets,
      );

      expect(
        find.byKey(MyDiscountsKeys.buttonAdd),
        findsWidgets,
      );
    },
  );
}
