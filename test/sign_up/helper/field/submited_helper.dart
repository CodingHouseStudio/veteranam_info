import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> submitedHelper(
  WidgetTester tester,
) async {
  await signUpFieldsHelper(
    tester: tester,
    password: KTestVariables.passwordCorrect,
    email: KTestVariables.userEmail,
    dataIsCorrect: true,
  );

  expect(find.byKey(SignUpKeys.submitingText), findsOneWidget);

  // expect(find.byKey(SignUpKeys.submitingText), findsNothing);
  // await dialogSnackBarTextHelper(tester: tester, showDialog: false);
}
