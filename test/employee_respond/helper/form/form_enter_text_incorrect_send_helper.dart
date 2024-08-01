import 'package:flutter_test/flutter_test.dart';

import '../../../text_dependency.dart';
import '../helper.dart';

Future<void> formIncorrectSendHelper(
  WidgetTester tester,
) async {
  await formEnterTextHelper(
    tester: tester,
    email: KTestText.userEmailIncorrect,
    phoneNumber: KTestText.fieldEmpty,
  );

  await formFieldHelper(tester);
}
