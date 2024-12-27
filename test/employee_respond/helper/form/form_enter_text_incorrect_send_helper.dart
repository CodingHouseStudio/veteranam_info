import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> formIncorrectSendHelper(
  WidgetTester tester,
) async {
  await formEnterTextHelper(
    tester: tester,
    email: KTestVariables.userEmailIncorrect,
    phoneNumber: KTestVariables.fieldEmpty,
  );

  await formFieldHelper(tester);
}
