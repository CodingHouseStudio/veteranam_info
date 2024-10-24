import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsEditIdWrongInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.textWrongLink),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.imageWrongLink),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.pageIndicator),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountsAdd.buttonWrongLink),
        findsOneWidget,
      );
    },
  );
}
