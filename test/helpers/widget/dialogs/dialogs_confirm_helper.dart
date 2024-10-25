import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dialogConfirmChangesHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    scrollUp: false,
    windowsTest: true,
    size: KTestConstants.windowVerySmallSize,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.widget.confirmDialog.icon),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.confirmDialog.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.confirmDialog.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton),
        findsOneWidget,
      );
    },
  );
}
