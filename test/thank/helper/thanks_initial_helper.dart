import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> thanksInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.thanks.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.thanks.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.thanks.myProfielBox),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.thanks.homeBox),
        findsOneWidget,
      );
    },
  );
}
