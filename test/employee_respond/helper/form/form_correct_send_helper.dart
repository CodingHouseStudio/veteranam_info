import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> formCorrectSendHelper(
  WidgetTester tester,
) async {
  await formEnterTextHelper(
    tester: tester,
    email: KTestText.userEmail,
    phoneNumber: KTestText.phoneNumber,
  );

  // await formFieldHelper(tester);
}
