import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> myDiscountUnconfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool icon,
  bool deskOpen = false,
}) async {
  if (deskOpen) {
    await changeWindowSizeHelper(
      tester: tester,
      test: () async => myDiscountDialogHelper(tester),
    );
  } else {
    await myDiscountDialogHelper(tester);
  }

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      if (find.byKey(ConfirmDialogKeys.title).evaluate().isEmpty) {
        await myDiscountDialogHelper(tester);
      }

      if (icon) {
        await confirmDialogCancelIconHelper(
          tester,
        );
      } else {
        await confirmDialogUnconfirmHelper(
          tester,
        );
      }
    },
  );
}
