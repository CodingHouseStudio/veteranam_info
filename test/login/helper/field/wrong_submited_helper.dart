import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> wrongSubmitedHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestText.passwordWrong,
    email: KTestText.useremailWrong,
    dataIsCorrect: true,
  );

  expect(find.byKey(KWidgetkeys.screen.login.submitingText), findsOneWidget);
  // await dialogSnackBarTextHelper(tester: tester);
}
