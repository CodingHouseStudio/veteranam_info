import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';
import '../helper.dart';

Future<void> incorrectPasswordHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestText.passwordIncorrect,
    email: KTestText.userEmail,
    dataIsCorrect: false,
  );

  expect(find.byKey(KWidgetkeys.screen.login.failureMessage), findsNothing);
}
