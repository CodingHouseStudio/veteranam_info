import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';
import '../helper.dart';

Future<void> wrongSubmitedHelper(
  WidgetTester tester,
) async {
  await signUpFieldsHelper(
    tester: tester,
    password: KTestText.passwordWrong,
    email: KTestText.useremailWrong,
    dataIsCorrect: true,
  );

  await dialogFailureSetHelper(tester: tester);
}
