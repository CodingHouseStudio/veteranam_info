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
  //     test: () async => profileLogOutHelper(tester),
  //   );
  // } else {
  //   await profileLogOutHelper(tester);
  // }

  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await profileLogOutHelper(tester);
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
