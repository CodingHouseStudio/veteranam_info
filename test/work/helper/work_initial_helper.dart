import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(WorkKeys.boxEmployer),
        findsOneWidget,
      );

      expect(
        find.byKey(WorkKeys.boxEmployee),
        findsOneWidget,
      );

      expect(
        find.byKey(WorkKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(WorkKeys.title),
        findsOneWidget,
      );

      // await footerHelper(tester);
    },
  );
}
