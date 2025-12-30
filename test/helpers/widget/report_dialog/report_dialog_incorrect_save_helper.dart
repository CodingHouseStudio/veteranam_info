import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_dependency.dart';

Future<void> reportDialogIncorrectSendHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required Key? popupMenuKey,
  bool fieldNull = false,
}) async {
  await reportDialogOpenHelper(tester: tester, popupMenuKey: popupMenuKey);

  await reportDialogEnterTextHelper(
    tester: tester,
    // email: fieldNull ? null : KTestVariables.userEmailIncorrect,
    message: fieldNull ? null : KTestVariables.fieldEmpty,
  );

  await reportDialogFieldHelper(tester);

  verifyNever(() => mockGoRouter.pop());
}
