import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../../test_dependency.dart';

Future<void> dialogConfirmChangesHelper({
  required WidgetTester tester,
  bool hasTimer = false,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.timer),
    hasTimer ? findsOneWidget : findsNothing,
  );
  if (hasTimer) {
    await tester.pumpAndSettle(
      const Duration(seconds: KDimensions.confirmdialogTimerDelay * 2),
    );
    expect(
      find.byKey(KWidgetkeys.widget.confirmDialog.timer),
      findsNothing,
    );
  }
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
