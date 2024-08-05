import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> workInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.work.boxEmployer),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.work.boxEmployee),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.work.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.work.title),
        findsOneWidget,
      );

      // await footerHelper(tester);
    },
  );
}
