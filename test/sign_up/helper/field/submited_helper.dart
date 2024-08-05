import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> submitedHelper(
  WidgetTester tester,
) async {
  await signUpFieldsHelper(
    tester: tester,
    password: KTestText.passwordCorrect,
    email: KTestText.userEmail,
    dataIsCorrect: true,
  );

  await dialogFailureSetHelper(tester: tester, isFailure: false);
}
