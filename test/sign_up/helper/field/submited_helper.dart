import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';
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

  expect(
    find.byKey(KWidgetkeys.screen.signUp.failureMessage),
    findsNothing,
  );
}
