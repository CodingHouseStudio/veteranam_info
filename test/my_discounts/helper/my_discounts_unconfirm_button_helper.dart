import 'package:flutter_test/flutter_test.dart';

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
      if (icon) {
        await dialogCancelIconHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      } else {
        await dialogUnconfirmHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );
      }
    },
  );
}