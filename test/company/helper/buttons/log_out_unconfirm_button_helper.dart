import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> logOutUnconfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required bool icon,
  // bool deskOpen = false,
}) async {
  // if (deskOpen) {
  //   await changeWindowSizeHelper(
  //     tester: tester,
  //     test: () async => companyLogOutHelper(tester),
  //   );
  // } else {
  //   await companyLogOutHelper(tester);
  // }

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await companyLogOutHelper(tester);
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
