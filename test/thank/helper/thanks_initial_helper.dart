import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> thanksInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(ThanksKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(ThanksKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(ThanksKeys.myProfielBox),
        findsOneWidget,
      );

      expect(
        find.byKey(ThanksKeys.homeBox),
        findsOneWidget,
      );
    },
  );
}
