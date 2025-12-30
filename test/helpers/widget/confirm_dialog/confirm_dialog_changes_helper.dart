import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/shared_flutter.dart';
import '../../../test_dependency.dart';

Future<void> confirmDialogChangesHelper({
  required WidgetTester tester,
  bool hasTimer = false,
}) async {
  expect(
    find.byKey(ConfirmDialogKeys.timer),
    hasTimer ? findsOneWidget : findsNothing,
  );
  if (hasTimer) {
    await tester.pumpAndSettle(
      const Duration(seconds: KDimensions.confirmdialogTimerDelay * 2),
    );
    expect(
      find.byKey(ConfirmDialogKeys.timer),
      findsNothing,
    );
  }
  await changeWindowSizeHelper(
    tester: tester,
    scrollUp: false,
    windowsTest: true,
    // size: KTestConstants.windowVerySmallSize,
    test: () async {
      expect(
        find.byKey(ConfirmDialogKeys.cancelIcon),
        findsOneWidget,
      );

      expect(
        find.byKey(ConfirmDialogKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(ConfirmDialogKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(ConfirmDialogKeys.confirmButton),
        findsOneWidget,
      );

      expect(
        find.byKey(ConfirmDialogKeys.unconfirmButton),
        findsOneWidget,
      );
    },
  );
}
