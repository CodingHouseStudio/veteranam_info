import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> wrongSubmitedHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestVariables.passwordWrong,
    email: KTestVariables.useremailWrong,
    dataIsCorrect: true,
  );

  expect(find.byKey(LoginKeys.submitingText), findsOneWidget);
  // await dialogSnackBarTextHelper(tester: tester);
}
