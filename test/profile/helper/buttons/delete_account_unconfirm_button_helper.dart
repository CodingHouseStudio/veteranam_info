import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> deleteAccountUnconfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool icon,
  bool deskOpen = false,
}) async {
  if (deskOpen) {
    await changeWindowSizeHelper(
      tester: tester,
      test: () async => profileDeleteButtonHelper(tester),
    );
  } else {
    await profileDeleteButtonHelper(tester);
  }

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      if (find
          .byKey(KWidgetkeys.widget.confirmDialog.cancelIcon)
          .evaluate()
          .isEmpty) {
        await deleteAccountDialoglHelper(tester);
      }
      if (icon) {
        await confirmDialogCancelIconHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      } else {
        await confirmDialogUnconfirmHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      }
    },
  );
}
