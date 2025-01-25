import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogIncorrectSendHelper({
  required WidgetTester tester,
  bool fieldNull = false,
}) async {
  await reportDialogOpenHelper(tester);

  await reportDialogEnterTextHelper(
    tester: tester,
    email: fieldNull ? null : KTestVariables.userEmailIncorrect,
    message: fieldNull ? null : KTestVariables.fieldEmpty,
  );

  await reportDialogFieldHelper(tester);
}
