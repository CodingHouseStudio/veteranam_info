import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> submitedHelper(
  WidgetTester tester,
) async {
  await loginFieldsHelper(
    tester: tester,
    password: KTestText.passwordCorrect,
    email: KTestText.userEmail,
    dataIsCorrect: true,
  );

  expect(find.byKey(KWidgetkeys.screen.login.submitingText), findsOneWidget);

  // expect(find.byKey(KWidgetkeys.screen.login.submitingText), findsNothing);

  // await dialogSnackBarTextHelper(tester: tester, showDialog: false);
}
