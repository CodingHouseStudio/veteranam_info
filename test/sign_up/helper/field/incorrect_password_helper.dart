import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> incorrectPasswordHelper(
  WidgetTester tester,
) async {
  await signUpFieldsHelper(
    tester: tester,
    password: KTestText.passwordIncorrect,
    email: KTestText.userEmail,
    dataIsCorrect: false,
  );

  await dialogFailureSetHelper(tester: tester, isFailure: false);
}
