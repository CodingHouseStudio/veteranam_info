import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> reportDialogEnterTextHelper({
  required WidgetTester tester,
  required String? message,
  // required String? email,
}) async {
  await reportDialogCheckEnterHelper(
    tester,
  );

  await reportDialogFieldHelper(tester);

  // await scrollingHelper(
  //   tester: tester,
  //   itemKey: ReportDialogKeys.emailField,
  // );

  // if (email != null) {
  //   await tester.enterText(
  //     find.byKey(ReportDialogKeys.emailField),
  //     email,
  //   );
  // }

  await scrollingHelper(
    tester: tester,
    itemKey: ReportDialogKeys.messageField,
  );

  if (message != null) {
    await tester.enterText(
      find.byKey(ReportDialogKeys.messageField),
      message,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: ReportDialogKeys.sendButton,
  );

  await tester.tap(find.byKey(ReportDialogKeys.sendButton));

  await tester.pumpAndSettle();
}
