import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
  //   itemKey: KWidgetkeys.widget.reportDialog.emailField,
  // );

  // if (email != null) {
  //   await tester.enterText(
  //     find.byKey(KWidgetkeys.widget.reportDialog.emailField),
  //     email,
  //   );
  // }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.messageField,
  );

  if (message != null) {
    await tester.enterText(
      find.byKey(KWidgetkeys.widget.reportDialog.messageField),
      message,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.reportDialog.sendButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.reportDialog.sendButton));

  await tester.pumpAndSettle();
}
