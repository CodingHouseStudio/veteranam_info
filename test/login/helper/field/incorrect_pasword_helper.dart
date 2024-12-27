import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> incorrectPasswordHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestVariables.passwordIncorrect,
    email: KTestVariables.userEmail,
    dataIsCorrect: false,
  );

  await dialogSnackBarTextHelper(tester: tester, showDialog: false);
}
