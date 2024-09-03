import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogIncorrectSendHelper({
  required WidgetTester tester,
  bool fieldNull = false,
}) async {
  await reportDialogOpenHelper(tester);

  await reportDialogEnterTextHelper(
    tester: tester,
    // email: fieldNull ? null : KTestText.userEmailIncorrect,
    message: fieldNull ? null : KTestText.fieldEmpty,
  );

  await reportDialogFieldHelper(tester);
}
