import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogIncorrectSendHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  bool fieldNull = false,
}) async {
  await reportDialogOpenHelper(tester);

  await reportDialogEnterTextHelper(
    tester: tester,
    // email: fieldNull ? null : KTestText.userEmailIncorrect,
    message: fieldNull ? null : KTestVariables.fieldEmpty,
  );

  await reportDialogFieldHelper(tester);

  verifyNever(() => mockGoRouter.pop());
}
